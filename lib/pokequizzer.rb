require 'twitterclient'

class PokeQuizzer

  # TODOs:
  # if tweet contains? 'help', 
  #  reply with commands list and
  #  return
  # else if tweet contains? 'report',
  #  add the statusid, lastpokemonno, screenname etc to 'issues' table and 
  #  return
  def self.handle tweet
    #require 'byebug'; byebug
    return unless tweet.is_a? Twitter::Tweet
    ActiveRecord::Base.connection_pool.with_connection do
      begin
        pokequiz = PokeQuiz.find_by_screenname tweet.user.screen_name
        return handle_new_gamer tweet if pokequiz.nil?
        
        # row present
        return handle_live_game_session tweet, pokequiz if pokequiz.status == PokeQuiz::Status::LIVE
        return handle_returning_gamer tweet, pokequiz if pokequiz.status == PokeQuiz::Status::COMPLETED
      rescue Exception => e
        puts "Exception while handling tweet #{e.message}"
        puts e.backtrace.inspect
      end
    end #connection
  end


  class << self
    private

    def handle_new_gamer tweet
      screenname = tweet.user.screen_name
      statusid = tweet.id

      puts "#{screenname} is a new gamer"
      pokequiz = PokeQuiz.new_game screenname, statusid
      reply_for_new_game pokequiz
    end

    def handle_returning_gamer tweet, pokequiz
      screenname = tweet.user.screen_name
      new_statusid = tweet.id
      puts "#{screenname} is a returning gamer"
      pokequiz.renew_game! new_statusid
      reply_for_new_game pokequiz, first: false #returning game
    end

    def handle_live_game_session tweet, pokequiz
      msg = "#{tweet.user.screen_name} replied for a live game session"
      pokequiz.totalans += 1

      pokemonname = pokequiz.pokemon.name.downcase
      iscorrectanswer = true

      if tweet.text.downcase.include? pokemonname
        puts "#{msg} with a right answer"
      else
        puts "#{msg} with a wrong answer"
        pokequiz.wrongans += 1
        iscorrectanswer = false
      end

      return handle_end_of_game pokequiz, iscorrectanswer if pokequiz.end_of_game?

      return handle_next_question pokequiz, iscorrectanswer
    end

    def handle_end_of_game pokequiz, iscorrectanswer
      pokequiz.status = PokeQuiz::Status::COMPLETED
      pokequiz.save!
      reply_for_end_of_game pokequiz, iscorrectanswer
    end


    def handle_next_question pokequiz, iscorrectanswer
      puts "#{pokequiz.screenname}'s answer is #{iscorrectanswer ? 'correct' : 'wrong'}"
      
      correctanswer = pokequiz.pokemon.name
      pokequiz.prepare_next_question!
      
      reply_for_next_question pokequiz, iscorrectanswer, correctanswer
    end




    def reply_for_new_game pokequiz, first: true
      if first
        intro = ["Are you game for some PokeQuiz?", "How about some PokeQuiz?"].sample
        msg = "Hey @#{pokequiz.screenname}! #{intro} Can you guess the name of this Pokemon?"
      else
        intro = ["Welcome back @#{pokequiz.screenname}!", "Hey @#{pokequiz.screenname}! How do you do?"].sample
        msg = "#{intro} Let's have another quiz! What's this Pokemon?"
      end
      reply msg, pokequiz.statusid, File.new(pokequiz.pokemon.imagefilepath)
    end

    def reply_for_next_question pokequiz, iscorrectanswer, correctanswer
      if iscorrectanswer
        msg = ["@#{pokequiz.screenname} That's correct. ", "Good one @#{pokequiz.screenname}. "].sample
      else
        msg = "@#{pokequiz.screenname} That's #{correctanswer} :( "
      end

      msg << ["Try this..", "How about this?"].sample
      reply msg, pokequiz.statusid, File.new(pokequiz.pokemon.imagefilepath)
    end

    def reply_for_end_of_game pokequiz, iscorrectanswer

      if iscorrectanswer
        excl = ["Congrats", "Wow"].sample
        if pokequiz.wrongans == 0
          msg = "#{excl} @#{pokequiz.screenname}! That's a full score!"
          msg << "Please come again!" unless pokequiz.returninggamer
        else
          correctans = pokequiz.totalans - pokequiz.wrongans
          msg = "@#{pokequiz.screenname}! That's correct! Your score is #{correctans} out of #{pokequiz.totalans}"
        end
      else
        correctname = pokequiz.pokemon.name
        msg = "@#{pokequiz.screenname} That's #{correctname} :( "
        msg << " Bad luck today I suppose." if pokequiz.wrongans >= PokeQuiz::MAX_QUESTIONS - 1
        msg << " Please try again next time :/"
      end

      reply msg, pokequiz.statusid
    end



    def reply msg, statusid, media=nil
      if media.nil?
        puts "Updating '#{msg}'"
        TwitterClient[:main].update msg, in_reply_to_status_id: statusid
      else
        puts "Updating '#{msg}' with media"
        TwitterClient[:main].update_with_media msg, media, in_reply_to_status_id: statusid
      end
    rescue Exception => e
      puts "Exception while updating tweet #{e.message}"
      puts e.backtrace.inspect
    end



  end

end
