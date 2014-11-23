require 'image'
require 'twitter'

# Twitter bot that checks the past mentions and replies
class Bot

  @@tweet_api = Twitter.new

  def self.run_bot

    #Mentions since last run
    tweets = @@tweet_api.get_mentions

    return tweets
  end

end