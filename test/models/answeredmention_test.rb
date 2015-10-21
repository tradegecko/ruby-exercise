require 'test_helper'

class AnsweredmentionTest < ActiveSupport::TestCase
  def setup
    @answeredmention = Answeredmention.new(tweetid: 1233454)
  end

  test "should be valid" do
    assert @answeredmention.valid?
  end

  test "tweetid should be present" do
    @answeredmention.tweetid = nil
    assert_not @answeredmention.valid?
  end
end
