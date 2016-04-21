class TwitterBot
  attr_reader :screen_name, :tweet_listener, :tweeter

  def initialize(consumer_key, consumer_secret, access_token, access_token_secret)
    @tweeter = Twitter::REST::Client.new do |config|
      config.consumer_key        = consumer_key
      config.consumer_secret     = consumer_secret
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end

    @tweet_listener = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = consumer_key
      config.consumer_secret     = consumer_secret
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end

    @screen_name = @tweeter.verify_credentials.screen_name
  end

  def to_s
    "#{screen_name} bot"
  end

  # This method listen to the stream of tweets from the timeline and acts
  def listen_to_timeline
    puts "#{screen_name} - I'm alive : )"
    tweet_listener.user do |event|
      case event
        when Twitter::Tweet
          # mention of the bots name, most likely a message for the bot
          if /@#{screen_name}/ =~ event.text
            puts "It's a direct tweet! #{event.text}"
            respond_to_tweet(event)
            tweet_mood(event.user)
          end
        when Twitter::DirectMessage # TODO: direct messages don't seem to work
          puts "It's a direct message! #{event.text}"
        when Twitter::Streaming::StallWarning
          warn 'Falling behind!'
      end
    end
  end

  def respond_to_tweet(tweet)
    user_screen_name = tweet.user.screen_name == screen_name ? '' : "@#{tweet.user.screen_name} "
    message = Dialogue.respond_to(tweet.text.gsub("@#{screen_name}", ''), user_screen_name.length)
    if message.to_s.strip.length != 0
      tweeter.update(user_screen_name + message)
      puts "#{screen_name} tweeting : #{message}"
    else
      tweeter.update(user_screen_name + I18n.t('tweet.error.WolframAlpha'))
      puts "#{screen_name} tweeting : #{message}"
    end
  end

  def tweet_mood(user)
    user_tweets = tweeter.user_timeline(user.id).map!{|tweet| tweet.text unless tweet.retweet?}
    global_mood = MoodAnalyser.analyse_the_mood(user_tweets)
    if global_mood == :positive
      tweeter.update(user.screen_name + ' ' + I18n.t('tweet.mood.happy'))
    elsif global_mood == :negative
      tweeter.update(user.screen_name + ' ' + I18n.t('tweet.mood.unhappy'))
    end
  end

  # This method tweets a random quote
  def auto_tweet
    message = FamousQuotes.get_one
    if message.to_s.strip.length != 0
      puts "#{screen_name} tweeting : #{message}"
      tweeter.update(message)
    end
  end

  def self.all_auto_tweet
    TWITTER_BOTS.each do |bot|
      bot.auto_tweet
    end
    nil
  end
end
