require 'twitter'

class Tweet

  def initialize()
    @my_quotes = Quote.all
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['consumer_key']
      config.consumer_secret = ENV['consumer_secret']
      config.access_token = ENV['access_token']
      config.access_token_secret = ENV['access_token_secret']
    end
  end


  # tweet with a specific content specified
  # Params:
  # +tweet_content+:: body of tweet
  # @return RequestStatus
  def tweet(tweet_content = "Hola! Nothing to tweet about?")
    response = @client.update(tweet_content)
    return RequestStatus.new(true, response.text)

  rescue StandardError => e
    return RequestStatus.new(false, e.message)
  end


  # tweet hourly with a random quote from the database
  # Params:
  # @return RequestStatus
  def tweet_random_quote
    random_quote = generate_random_quote
    tweet random_quote
  end


  # respond to tweet by translating to a random language
  # Params:
  # @return RequestStatus
  def respond_tweet
    # get tweets to respond by retrieve last responded tweet in db and from twitter retrieve more recent tweets
    # drawback to possibly enhance: if manually answer via Twitter (not via this twitterbot, duplicate reply)
    tweets_to_respond = retrieve_tweets_from_mentions_timeline

    # processing tweets_to_respond
    if tweets_to_respond.is_a? RequestStatus
      # check if return RequestStatus instead then return the status
      return tweets_to_respond
    elsif tweets_to_respond && tweets_to_respond.empty?
      # check if any recent tweets needs responding
      return RequestStatus.new(false, "No tweet to respond!")
    else
      # execute respond on retrieved tweets
      begin
        execute_respond_on_tweets tweets_to_respond
      rescue StandardError => e
        return RequestStatus.new(false, e.message)
      end
    end

    return RequestStatus.new(true, "responding to #{tweets_to_respond.size}")
  end


  # helper private methods
  # generate tweet's body by translating - reuse translator
  def generate_respond_tweet x, translator
    # regex to remove first tag only
    text_removed_tags = x.text.sub(/(@\w+)/, '')

    # try generate 3 times, break if success
    translate_response = nil
    random_lang = nil
    3.times do
      random_lang = translator.supported_langs.sample
      translate_response = translator.translate_with_yandex(text_removed_tags, random_lang.code)
      # puts translate_response
      if translate_response.status
        break
      end
    end

    translated_text = translate_response.message

    return translate_response.status ?
        "In #{random_lang.language}, we say #{translated_text}" :
        "Thank you, but I don't wanna tweet now :)"
  end

  # reformat string of tags into twitter hashtags
  def put_hash_tag hashtags
    hashtags.gsub(/\s+/, "").split(",").map(&:strip).map { |x| '#'+x }.to_a.join(" ")
  end

  # generate random tweet with total tweet <= 140
  def generate_random_quote
    @my_quotes = Quote.all

    # retry 3 times if found quote <= 140 character limit
    3.times do
      sample = @my_quotes.to_a.sample
      tags = put_hash_tag sample.hashtags

      # if author doesn't exit => put unknown
      if sample.author?
        tweet_body = "#{sample.content} ~ #{sample.author} #{tags}"
      else
        tweet_body = tweet("#{sample.content} ~ Unknown #{tags}")
      end

      puts tweet_body.size
      if tweet_body.size <= 140
        return tweet_body
        # else
        #   puts tweet_body
      end
    end

    default = "Stay hungry. Stay foolish. ~ Steve Jobs #nothingbetterfound #lol"
    return default
  end

  # execute respond on specific tweets in arguments
  # 1. generate tweet content
  # 2. post the tweet
  # 3. save the respond record
  def execute_respond_on_tweets tweets_to_respond
    translator = Translator.new
    tweets_to_respond.each do |x|
      # generate tweet
      response_tweet_str = generate_respond_tweet(x, translator)

      # post the tweet
      retweet = @client.update("@#{x.user.screen_name} #{response_tweet_str}", in_reply_to_status_id: x.id)

      # insert new retweet record
      TweetRespondHistory.create(:respond_status_id => retweet.in_reply_to_status_id, tweet_text: retweet.text)
    end
  end

  # retrieve tweets from mentions in timeline
  # 1. get last respond object from TweetRespondHistory
  # 2. if object exist, get mentions_timeline only for tweets since after biggest id
  # 3. else retrieve response (max 20) from twitters, sorting oldest to most recent
  # return RequestStatus if operation fails (network failure, etc) else tweets_to_respond object
  def retrieve_tweets_from_mentions_timeline
    last_respond = TweetRespondHistory.order("respond_status_id DESC").first
    if last_respond && last_respond.respond_status_id?
      tweets_to_respond = @client.mentions_timeline(:since_id => last_respond.respond_status_id)
    else
      tweets_to_respond = @client.mentions_timeline.sort_by { |a| a.in_reply_to_status_id.to_s }.reverse
    end
    return tweets_to_respond
  rescue StandardError => e
    return RequestStatus.new(false, e.message)
  end

  private :put_hash_tag, :generate_respond_tweet, :generate_random_quote, :execute_respond_on_tweets, :retrieve_tweets_from_mentions_timeline
end