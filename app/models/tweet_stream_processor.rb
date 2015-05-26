class TweetStreamProcessor
  ACCOUNT_TWITTER_HANDLE = 'PlzValidateMe'

  def self.run
    rest_client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY'] # 'xvQvRjy3t0lNiE1PWTIMdbZa9'
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET'] # 'mY7vVpvzr4qc85ivSKN3zkhADlstUXx3WPHLGUNijO2SUq1Urv'
      config.access_token = ENV['TWITTER_ACCESS_TOKEN'] # '3297824835-u2QpvBcM45Zr2oGj5N4KBdAod7y1qd2KHj8UoDp'
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET'] # 'BlYs2eYlL5HJ405zBgp2PJekkf8r26ByVTLKL32BZPYB6'
    end

    streaming_client = Twitter::Streaming::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY'] # 'xvQvRjy3t0lNiE1PWTIMdbZa9'
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET'] # 'mY7vVpvzr4qc85ivSKN3zkhADlstUXx3WPHLGUNijO2SUq1Urv'
      config.access_token = ENV['TWITTER_ACCESS_TOKEN'] # '3297824835-u2QpvBcM45Zr2oGj5N4KBdAod7y1qd2KHj8UoDp'
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET'] # 'BlYs2eYlL5HJ405zBgp2PJekkf8r26ByVTLKL32BZPYB6'
    end

    new(rest_client, streaming_client).run
  end

  attr_reader :rest_client, :streaming_client, :redis

  def initialize(rest_client, streaming_client, redis = $redis)
    @rest_client = rest_client
    @streaming_client = streaming_client
    @redis = redis
  end

  def run
    streaming_client.user do |obj|
      case obj
      when Twitter::Tweet
        sender = obj.user.screen_name

        if sender != ACCOUNT_TWITTER_HANDLE && obj.text.include?(ACCOUNT_TWITTER_HANDLE)
          rest_client.update "Awww, I'm so happy @#{sender} thought of me."
          redis.incr "sender:#{sender}"
        end
      when Twitter::DirectMessage
        sender = obj.sender.screen_name

        if sender != ACCOUNT_TWITTER_HANDLE
          rest_client.update "@#{sender} Right back at you, friend!"
          redis.incr "sender:#{sender}"
        end
      end
    end
  end
end
