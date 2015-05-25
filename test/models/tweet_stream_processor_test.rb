require 'test_helper'
require 'minitest/autorun'

class TestTweetStreamProcessor < Minitest::Test
  def test_processing_direct_message
    rest_client = FakeTwitterRestClient.new
    redis = FakeRedis.new
    streaming_client = FakeTwitterStreamingClient.new(:direct)
    tweet_stream_processor = TweetStreamProcessor.new(rest_client, streaming_client, redis)

    tweet_stream_processor.run

    assert_equal 1, redis.incr_for_key('sender:DMer')
    assert_equal 0, redis.incr_for_key('sender:Tweeter')
    assert_equal ['@DMer Right back at you, friend!'], rest_client.updates
  end

  def test_processing_tweet
    rest_client = FakeTwitterRestClient.new
    redis = FakeRedis.new
    streaming_client = FakeTwitterStreamingClient.new(:tweet)
    tweet_stream_processor = TweetStreamProcessor.new(rest_client, streaming_client, redis)

    tweet_stream_processor.run

    assert_equal 0, redis.incr_for_key('sender:DMer')
    assert_equal 1, redis.incr_for_key('sender:Tweeter')
    assert_equal ["Awww, I'm so happy @Tweeter thought of me."], rest_client.updates
  end

  def test_processing_tweet_without_mention
    rest_client = FakeTwitterRestClient.new
    redis = FakeRedis.new
    streaming_client = FakeTwitterStreamingClient.new(:tweet_no_mention)
    tweet_stream_processor = TweetStreamProcessor.new(rest_client, streaming_client, redis)

    tweet_stream_processor.run

    assert_equal 0, redis.incr_for_key('sender:DMer')
    assert_equal 0, redis.incr_for_key('sender:Tweeter')
    assert_equal [], rest_client.updates
  end

  class FakeTwitterStreamingClient
    attr_reader :usecase

    def initialize(usecase)
      raise "#{usecase} not in :direct, :tweet, :tweet_no_mention" unless [:direct, :tweet, :tweet_no_mention].include? usecase
      @usecase = usecase
    end

    def user
      case usecase
      when :direct
        yield FakeDirectMessage.new
      when :tweet
        yield FakeTweet.new("I am a tweet, #{TweetStreamProcessor::ACCOUNT_TWITTER_HANDLE}")
      when :tweet_no_mention
        yield FakeTweet.new('Ordinary tweet in timeline.')
      end
    end

    class FakeDirectMessage < Twitter::DirectMessage
      def initialize; end

      def sender
        OpenStruct.new(screen_name: 'DMer')
      end
    end

    class FakeTweet < Twitter::Tweet
      def initialize(text)
        @text = text
      end

      def text
        @text
      end

      def user
        OpenStruct.new(screen_name: 'Tweeter')
      end
    end
  end

  class FakeTwitterRestClient
    def initialize
      @updates = []
    end

    def update(msg)
      @updates << msg
    end

    def updates
      @updates
    end
  end

  class FakeRedis
    def initialize
      @incrs = Hash.new(0)
    end

    def incr(key)
      @incrs[key] += 1
    end

    def incr_for_key(key)
      @incrs[key]
    end
  end
end
