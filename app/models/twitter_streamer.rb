class TwitterStreamer
  # For twitter's Streaming API (https://dev.twitter.com/streaming/overview)
  TWITTER_STREAM_CLIENT = Twitter::Streaming::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end

  def self.start
    TWITTER_STREAM_CLIENT.user do |object|
      quote = QuoteEngine.random
      case object
      when Twitter::Tweet
        Bot.tweet "@#{object.user.screen_name} #{quote.text}" unless object.user.screen_name == Bot::NAME
      when Twitter::DirectMessage
        Bot.reply object.sender unless object.sender.screen_name == Bot::NAME
      when Twitter::Streaming::StallWarning
        warn "Falling behind!"
      end
    end
  end
end
