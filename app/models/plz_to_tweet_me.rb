class PlzToTweetMe
  def self.run
    rest_client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY'] # 'xvQvRjy3t0lNiE1PWTIMdbZa9'
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET'] # 'mY7vVpvzr4qc85ivSKN3zkhADlstUXx3WPHLGUNijO2SUq1Urv'
      config.access_token = ENV['TWITTER_ACCESS_TOKEN'] # '3297824835-u2QpvBcM45Zr2oGj5N4KBdAod7y1qd2KHj8UoDp'
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET'] # 'BlYs2eYlL5HJ405zBgp2PJekkf8r26ByVTLKL32BZPYB6'
    end

    new(rest_client).run
  end

  attr_reader :rest_client, :redis

  def initialize(rest_client, redis = $redis)
    @rest_client = rest_client
    @redis = redis
  end

  def run
    tweeters = redis.keys 'sender:*' # yeah, this is slow. should manage a set of tweeters, too.

    if tweeters.empty?
      tweet_not_loved
    elsif tweeters.size == 1
      tweet_most_loved_by screen_name_for_redis_key(tweeters.first)
    else
      sorted_tweeters = redis.mget(tweeters).
        map.with_index { |tweet_count, i| {count: tweet_count.to_i, idx: i} }.
        sort_by { |hsh| hsh[:count] }.
        reverse

      if sorted_tweeters.first[:count] == sorted_tweeters.second[:count]
        tweet_equal_love
      else
        tweet_most_loved_by screen_name_for_redis_key(tweeters[sorted_tweeters.first[:idx]])
      end
    end

    tweeters.each { |key| redis.del key }
  end

  private

  def tweet_not_loved
    rest_client.update('Awww... I haz a sad. Why nobody likes me?')
  end

  def tweet_equal_love
    rest_client.update("Oh, frabjous day! I'm loved by so many people equally!")
  end

  def tweet_most_loved_by(name)
    rest_client.update("Thanks, @#{name}. You love me the most!")
  end

  def screen_name_for_redis_key(key)
    key.sub('sender:', '')
  end
end
