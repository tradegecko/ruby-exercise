class TwitterBot
  include Twitter::Extractor
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
      @client.update "@#{mention.screen_name} #{tweet.content}", in_reply_to_status_id: mention.mention_tweet_id.to_i
      tweet.tweet!
    end
  rescue StandardError => e
    puts "StandardError: #{e}"
  end

  def sync_mentions
    @client.mentions_timeline.each do |tweet|
      next if tweet.user.id == @client.current_user.id
      next if Mention.exists? mention_tweet_id: tweet.id.to_s
      Mention.create(content: tweet.text, mention_tweet_id: tweet.id.to_s, screen_name: tweet.user.screen_name )
    end
  end

  def gather_tweet_data count=10
    @client.search("#kpop", :result_type => "recent").take(count).collect do |tweet|
      text = tweet.text.dup
      unwanted = []
      unwanted += extract_urls(text)
      unwanted += extract_hashtags(text)
      unwanted += extract_mentioned_screen_names(text)
      unwanted += ['@', '#']
      unwanted.each {|u| text.gsub!(u, '')}
      next if text =~ /http/
      TweetData.create(content: text, hashtag: 'kpop')
    end
  end
end
