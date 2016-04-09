class TwitterBot
  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['consumer_key']
      config.consumer_secret     = ENV['consumer_secret']
      config.access_token        = ENV['access_token']
      config.access_token_secret = ENV['access_token_secret']
    end
  end

  def tweet
    return unless tweet = Tweet.unsent.last
    @client.update tweet.content
    tweet.tweet!
  rescue StandardError => e
    puts "StandardError: #{e}"
  end

  def reply
    return if Tweet.unreplied.empty?
    Tweet.unreplied.each do |tweet|
      mention = tweet.mention
      mentioner = client.user mention.sender_twitter_id.to_i
      @client.update "@#{mentioner.screen_name} #{tweet.content}", in_reply_to_status_id: mention.mention_tweet_id.to_i
      tweet.tweet!
    end
  rescue StandardError => e
    puts "StandardError: #{e}"
  end

  def sync_mentions
    @client.mentions_timeline.each do |tweet|
      next if tweet.user.id == @client.current_user.id
      next if Mention.exists? mention_tweet_id: tweet.id.to_s
      Mention.create(content: tweet.text, mention_tweet_id: tweet.id.to_s, sender_twitter_id: tweet.user.id.to_s )
    end
  end
end
