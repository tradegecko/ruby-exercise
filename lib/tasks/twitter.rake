require 'angel'
include Angel

namespace :twitter do
  task process: [:environment] do
    bot_name = ENV["BOT_NAME"]
    last_tweet = Timeline.last.tweet_id.to_i
    TwitterClient.mentions_timeline({:since_id => last_tweet}).each do |tweet|
      startup = tweet.text.gsub(bot_name, "").strip
      author = tweet.user.screen_name
      puts "Got a new tweet to process from @#{author} on startup - #{startup}. Off to work."
      timeline = Timeline.new(:tweet_id => tweet.id, :tweet => tweet.text, :tweet_by => author,
        :mentioned_startup => startup)

      result = Angel.get_similar startup

      puts "Replying to User."
      unless result
        puts "Couldn't find the startup or there were some obstacles."
        timeline.replied_startup = "NA"
        post_tweet(author, "Couldn't find the startup name, either u've misspelled or i'm drunk..")
      else
        timeline.replied = true
        timeline.replied_startup = result[:name]
        post_tweet(author, "Similar: #{result[:name]} - #{result[:summary]}")
      end
      timeline.save!
    end
    puts "All Done! Going to sleep."
  end
end

def post_tweet author, message
  TwitterClient.update("@#{author}: #{message}")
end
