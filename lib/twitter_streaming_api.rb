require 'twitter'

class TwitterStreamingApi
  def initialize
    @client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
      config.access_token        = Rails.application.secrets.twitter_access_token
      config.access_token_secret = Rails.application.secrets.twitter_access_token_secret
    end
  end

  def stream(keyword)
    @client.filter(track: keyword) do |object|
    yield object if object.is_a?(Twitter::Tweet) and block_given?
    end
  end
end