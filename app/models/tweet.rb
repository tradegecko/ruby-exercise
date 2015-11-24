class Tweet < ActiveRecord::Base
  validates_presence_of :twitter_ref

  belongs_to :gif

  def twitter_api
    @twitter_api ||= TwitterApi.new
  end

  def self.tweet_random_gif(keyword)
    tweet = Tweet.new(
        gif: Gif.get_random_gif(keyword)
    )
    tweet.tweet_and_save
  rescue ActiveRecord::RecordInvalid => errors
    Rails.logger.error errors.to_s
  end

  def tweet_and_save
    self.update!(twitter_ref: self.tweet_to_twitter.id.to_i)
  end

  def tweet_to_twitter
    twitter_api.tweet(nil, self.gif.file)
  end
end