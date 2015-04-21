# A class for handling the tweeting and replying tasks.
# Called from rake scheduler tasks. 
# IMPORTANT: make sure you set Twitter client credentials in ENV 
class TwitterClient

  def self.tweet_and_reply
    puts "Starting tweet_and_reply task..."

    puts "Configuring client..."
    configure_client

    puts 'Replying to mentions...'
    reply_to_mentions
    
    puts 'Tweeting...'
    tweet
    
    puts "Done"
  end

  private

  # Authenticate the application
  def self.configure_client
    if @client.nil?
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
      end
    end
  end

  # Get mentions since last tweet and reply to them
  def self.reply_to_mentions
    tweets = @client.mentions_timeline({:since_id => self.last_tweet_id}) rescue nil
    tweets.try(:each) do |tweet|
      puts tweet.text
    end
  end

  # Post a new tweet
  def self.tweet
    tweet = @client.update("The scheduler is still alive!") rescue nil
    # self.last_tweet_id = tweet.id unless tweet.nil?
  end

  # A setter for last tweet id. Used to filter the mentions 
  def self.last_tweet_id=(value)
    Rails.cache.write('last_tweet_id', value) unless value < 1
  end

  # A getter for last tweet id. Used to filter the mentions
  def self.last_tweet_id
    Rails.cache.read('last_tweet_id') || 1
  end
end