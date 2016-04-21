require 'tweetstream'

class TwitterListener
  
  def self.listen(&block)

    TweetStream.configure do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      config.auth_method        = :oauth
    end

    @@stream = TweetStream::Client.new

    @@stream.on_inited do
      puts "stream on_init"
    end

    @@stream.on_reconnect do
      puts "stream on_reconnect"
    end


    @@stream.userstream do |status|

      puts "[userstream] received status: #{status[:id]} #{status.user.inspect} #{status.in_reply_to_screen_name.inspect}"
      return unless status is_a? Twitter::Tweet
    end

  end

end
puts "Listening to stream"
TwitterListener.listen
puts "Listening complete"