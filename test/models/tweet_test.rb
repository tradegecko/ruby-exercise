require 'test_helper'

class TweetTest < ActiveSupport::TestCase

  test "the successful" do
    response = Tweet.new.tweet('I love you')
    response = Tweet.new.tweet()
    puts response.text

    assert (response)
  end
end