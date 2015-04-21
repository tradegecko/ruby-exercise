# A class for handling the tweeting and replying tasks.
# Called from rake scheduler tasks.
# IMPORTANT: make sure you set Twitter client credentials in ENV

require 'math_test'

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
    puts "getting mentiones after tweet: #{self.last_tweet_id}"
    tweets = @client.mentions_timeline({:since_id => self.last_tweet_id}) rescue nil
    
    # For new each mention: Get the user's answer and the tweet to which he replied
    # to validate the answer
    tweets.try(:each) do |tweet|
      begin
        # In order not to reply to old mentions, set the allowed window to 1 day
        next if tweet.created_at < 1.day.ago
        
        answer = tweet.text
        question_status_id = tweet.in_reply_to_status_id
        question = @client.status(question_status_id) rescue nil
        unless question.nil?
          result = MathTest.validate_answer(question.text, answer)
          @client.update(
            "@#{tweet.user.screen_name} Your answer is #{result}!",
            :in_reply_to_status_id => tweet.id)
        end
      rescue Exception => e
        puts "Error for tweet: #{tweet.id}"
        puts e
      end
    end
  end

  # Post a new tweet
  def self.tweet
    tweet = @client.update("A new test: #{MathTest.genarate_equation}") rescue nil
    self.last_tweet_id = tweet.id unless tweet.nil?
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