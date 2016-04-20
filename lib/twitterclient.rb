require 'twitter'
require 'tweetstream'

class TwitterClient
  include Singleton

  def initialize
    TweetStream.configure do |conf|
      conf.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      conf.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      conf.oauth_token         = ENV['TWITTER_ACCESS_TOKEN']
      conf.oauth_token_secret  = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      conf.auth_method         = :oauth
    end
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def listen_to_stream #lifted from https://github.com/tweetstream/tweetstream-rails-example/blob/master/lib/tweet_streamer.rb
    @stream = TweetStream::Daemon.new 'tweet_streamer', log_output: true

    @stream.on_inited do
      puts "daemon on_init"
    end

    @stream.userstream do |status|
      puts status.inspect
    end

  end

end

TwitterClient.instance.listen_to_stream
