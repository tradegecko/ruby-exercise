require 'twitter_api'
require 'the_game_gal_api'

class Tweet < ActiveRecord::Base
  validates_presence_of :twitter_ref

  belongs_to :gif

  def twitter_api
    @twitter_api ||= TwitterApi.new
  end

  def self.tweet_random_words
    fetch_random_words = TheGameGalApi.fetch_random_words
    fetch_random_words.each { |word| tweet_and_save({ text: word }) }
  end

  def self.tweet_random_gif(keyword)
    random_gif = Gif.get_random_gif(keyword)
    tweet_and_save({ gif: random_gif}) if random_gif
  end

  def self.tweet_and_save(params)
    tweet = Tweet.create(params)
    tweet.update!(twitter_ref: tweet.tweet_to_twitter.id.to_i)
  rescue ActiveRecord::RecordInvalid => errors
    Rails.logger.error errors.to_s
  end

  def tweet_to_twitter
    twitter_api.tweet(self.text, self.gif.try(:file))
  end
end