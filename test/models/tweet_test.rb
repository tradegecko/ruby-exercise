require 'test_helper'

class TweetTest < ActiveSupport::TestCase

  test "the successful tweet" do
    response = Tweet.new.tweet('I love you')
    puts response
    assert (response)
  end

  test "the successful tweet random" do
    response = Tweet.new.tweet_random_quote
    puts response
    assert (response)
  end

  test "the successful respond" do
    response = Tweet.new.respond_tweet
    puts response

    assert (response)
  end
end