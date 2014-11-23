require 'twitter'
require 'yaml'

# Interface to access Twitter's REST API
class TwitterApi

  def initialize
    # Load keys and tokens from config.yml
    keys = YAML.load(File.read('config/twitter.yml'))

    begin
      # Create the REST client object for @colormyhex
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = keys['consumer_key']
        config.consumer_secret     = keys['consumer_secret']
        config.access_token        = keys['access_token']
        config.access_token_secret = keys['access_token_secret']
      end
    rescue Exception => details
      #log exception
      Rails.logger.fatal "Failed to load the client: #{details}"
    end

  end

  # Gets the tweets with mentions since the last time checked
  def get_mentions
    # Get id of last tweet checked
    last_id = CheckHistory.last_id
    
    if(last_id == nil)
      # Get all tweets
      tweets = @client.mentions_timeline
    else
      # Get all tweets since last id
      tweets = @client.mentions_timeline(since_id: last_id)
    end

    # Update last tweet checked in db
    if(tweets.count > 0)
      CheckHistory.set_last_id(tweets.first.id)
    end

    return tweets
  end

  # Tweet
  def post_tweet_with_color(tweet, hex, media)
    handle = tweet.user.screen_name.to_s
    new_tweet = "@#{handle} This is what #{hex} looks like."
    @client.update_with_media(new_tweet, media, options = {:in_reply_to_status => tweet})
  end

  # Tweet
  def post_tweet_with_hex(tweet, hex, media)
    handle = tweet.user.screen_name.to_s
    new_tweet = "@#{handle} The dominant color for the pic seems to be the hex value #{hex}. Here is a sample image for it."
    @client.update_with_media(new_tweet , media, options = {:in_reply_to_status => tweet})
  end

end
