require 'test_helper'
require 'minitest/autorun'

class TestPlzToTweetMe < Minitest::Test
  def test_no_tweeters
    redis = FakeRedis.new({})
    twitter_client = FakeTwitterRestClient.new

    PlzToTweetMe.new(twitter_client, redis).run

    assert_equal ['Awww... I haz a sad. Why nobody likes me?'], twitter_client.updates
  end

  def test_one_tweeter
    redis = FakeRedis.new({'sender:OneTweeter' => '1'})
    twitter_client = FakeTwitterRestClient.new

    PlzToTweetMe.new(twitter_client, redis).run

    assert_equal ["Thanks, @OneTweeter. You love me the most!"], twitter_client.updates
    assert_equal true, redis.deleted_keys.include?('sender:OneTweeter')
  end

  def test_tied_tweeters
    redis = FakeRedis.new({'sender:Somebody' => '2', 'sender:SomebodyElse' => '2'})
    twitter_client = FakeTwitterRestClient.new

    PlzToTweetMe.new(twitter_client, redis).run

    assert_equal ["Oh, frabjous day! I'm loved by so many people equally!"], twitter_client.updates
    assert_equal true, redis.deleted_keys.include?('sender:Somebody')
    assert_equal true, redis.deleted_keys.include?('sender:SomebodyElse')
  end

  def test_most_loved_tweeter
    redis = FakeRedis.new({'sender:OneTweeter' => '1', 'sender:ThreeTweeter' => '3'})
    twitter_client = FakeTwitterRestClient.new

    PlzToTweetMe.new(twitter_client, redis).run

    assert_equal ["Thanks, @ThreeTweeter. You love me the most!"], twitter_client.updates
    assert_equal true, redis.deleted_keys.include?('sender:OneTweeter')
    assert_equal true, redis.deleted_keys.include?('sender:ThreeTweeter')
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
    attr_reader :data, :deleted_keys

    # { 'sender:foo' => '3', 'sender:bar' => '1' }
    def initialize(data)
      @data = data
      @deleted_keys = []
    end

    def keys(pattern)
      data.keys
    end

    def del(key)
      deleted_keys << key
    end

    def mget(keys)
      keys.map { |key| data[key].to_s }
    end
  end
end
