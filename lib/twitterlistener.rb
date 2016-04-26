require 'tweetstream'
require 'twitterclient'
require 'pokequizzer'

class TwitterListener
  
  def self.listen

    TweetStream.configure do |config|
      puts 'configuring'
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = ENV['TWITTER_MAIN_ACCESS_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_MAIN_ACCESS_TOKEN_SECRET']
      config.auth_method        = :oauth
      #puts config.to_yaml
      #puts ENV.to_yaml
    end

    stream = TweetStream::Client.new

    stream.on_inited do
      puts "stream on_init"
    end

    stream.on_error do |msg|
      puts "stream on_error #{msg.inspect}"
    end

    stream.on_reconnect do |timeout, retries|
      puts "stream on_reconnect timeout - #{timeout} retries - #{retries}"
      #puts caller
    end
    
    stream.on_unauthorized do
     puts "on_unauthorized"
    end

    stream.on_enhance_your_calm do
     puts "Rate limit exceeded"
    end

    stream.userstream do |tweet|
      puts "[userstream] received status: #{tweet.id}"
      
      # don't block the event loop
      # https://dev.twitter.com/streaming/overview/connecting#Disconnections
      EM.defer self.dispatch_to_handler(tweet)
      
    end

    # hit Control + C to stop
    Signal.trap("INT")  { EM.stop }
    Signal.trap("TERM") { EM.stop }

  end


  def self.dispatch_to_handler tweet
    Proc.new {

      begin
        next unless tweet.is_a? Twitter::Tweet

        next if tweet.user.screen_name == ENV['TWITTER_SCREENNAME']
        
        puts "tweet from: #{tweet.user.screen_name} to: #{tweet.in_reply_to_screen_name}"
        PokeQuizzer.handle tweet
        #TwitterClient[:main].update "@#{tweet.user.screen_name} Hello There :D", in_reply_to_status: tweet 
        #TwitterClient[:main].update "@#{tweet.user.screen_name} Hello There2 :D", in_reply_to_status: tweet
      rescue Exception => e
        puts "Error while processing #{tweet}"
        puts e.message
        puts e.backtrace.inspect
      end

    }
  end

end
puts "Listening to stream"
TwitterListener.listen
puts "Listening ended"