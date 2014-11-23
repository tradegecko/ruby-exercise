require 'image'
require 'twitter_api'

# Twitter bot that checks the past mentions and replies
class Bot

  @@tweet_api = TwitterApi.new

  def self.run_bot

    #Mentions since last run
    tweets = @@tweet_api.get_mentions

     #Check if any tweets exist
    if(tweets.count != 0)
      tweets.each do |tweet|
          # If tweet contains a hex value,
          # tweet back the sample image for the color
          self.tweet_pic_for_hex(tweet)
          # If tweet contains a picture,
          # tweet back the hex and sample image for the color
          self.tweet_hex_for_pic(tweet)
      end
      # Clear all temp img files in folder
      Image.clear_saved_images
    end

    return tweets
  end

  # Tweet a sample image for hex value in a mention
  def self.tweet_pic_for_hex(tweet)

    # Check for hex value in tweet, of forms #ffffff and #fff
    match_values = tweet.text.match(/(#[a-f\d]{6}|#[a-f\d]{3})/i)

    # If no matches were found
    if(match_values != nil)
      # Get the matched hex value
      hex_value = match_values[0]
      # Post tweet with image
      @@tweet_api.post_tweet_with_color(tweet, hex_value, Image.get_image_url_for_hex(hex_value))
      return true
    end

    return false
  end

  # Tweet the hex for a pic in a mention
  def self.tweet_hex_for_pic(tweet)
    # Extract media from tweet
    media = tweet.media
    # If media exists
    if(media.count > 0)
      media_url =  media.first.media_url.to_s
      hex = Image.get_hex_value(media_url)
      # Post tweet with hex value and sample color image
      @@tweet_api.post_tweet_with_hex(tweet, hex, Image.get_image_url_for_hex(hex))
    end
  end

end