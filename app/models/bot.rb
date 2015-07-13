class Bot
  TWEET_MAX_LENGTH = 140
  NAME = "GeckoQuoteBot"

  # For twitter's REST API (https://dev.twitter.com/rest/public)
  TWITTER_REST_CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end

  def self.tweet_a_quote
    tweet QuoteEngine.random.text
  end

  def self.tweet text
    TWITTER_REST_CLIENT.update text.truncate(TWEET_MAX_LENGTH)
  end

  def self.reply user
    TWITTER_REST_CLIENT.create_direct_message user, QuoteEngine.random.text
  end
end
