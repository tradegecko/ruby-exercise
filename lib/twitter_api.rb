require 'twitter'

class TwitterApi

  DEFAULT_TWEET_COUNT=100

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

  private
  def with_search_suffix(keyword)
    "#{keyword} -RT"
  end
end