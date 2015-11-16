require 'twitter'

class TwitterApi

  DEFAULT_TWEET_COUNT=100
  MAX_TWEET_MESSAGE_LENGTH=140

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
      config.access_token        = Rails.application.secrets.twitter_access_token
      config.access_token_secret = Rails.application.secrets.twitter_access_token_secret
    end
  end

  def fetch_tweets(keyword)
    @client.search(with_search_suffix(keyword), result_type: 'recent').take(DEFAULT_TWEET_COUNT)
  end

  def tweet(message)
    validate_message(message)
    @client.update(message)
  end

  private
  def with_search_suffix(keyword)
    "#{keyword} -RT"
  end

  def validate_message(message)
    raise(ArgumentError, "Message can't be empty") if message.blank?
    raise(ArgumentError, "Message more than #{MAX_TWEET_MESSAGE_LENGTH} characters") if message.length > MAX_TWEET_MESSAGE_LENGTH
  end
end