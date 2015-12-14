class TweetComposer
  TWEET_LENGTH = 116

  def self.compose_dream_tweet(tweet, filter)
    s = "RT @#{tweet.user.attrs[:screen_name]} #deepdreaming ##{filter} #{tweet.full_text}"
    ActiveSupport::Multibyte::Chars.new(s).normalize(:c)[0...TWEET_LENGTH]
  end
end
