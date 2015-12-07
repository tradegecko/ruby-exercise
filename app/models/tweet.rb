require 'twitter_rest_api'
require 'twitter_streaming_api'
require 'the_game_gal_api'

class Tweet < ActiveRecord::Base
  validates_presence_of :twitter_ref
  belongs_to :gif
  delegate :file, to: :gif

  def twitter_api
    @twitter_api ||= TwitterRestApi.new
  end

  def self.twitter_streaming_api
    @twitter_streaming_api ||= TwitterStreamingApi.new
  end

  def self.tweet_random_words
    fetch_random_words = TheGameGalApi.fetch_random_words
    fetch_random_words.each { |word| tweet_and_save({text: word })}
  end

  def self.tweet_random_gif(keyword, in_reply_to_tweet_id=nil, replying_to_user_handle=nil)
    random_gif = Gif.get_random_gif(keyword)
    (Rails.logger.info "Gif not found for #{keyword}.." && return) unless random_gif
    tweet_and_save({gif: random_gif, in_reply_to_tweet_id: in_reply_to_tweet_id, replying_to_user_handle: replying_to_user_handle})
  end

  def self.tweet_and_save(params)
    tweet = Tweet.create(params)
    tweet.update!(twitter_ref: tweet.tweet_to_twitter.id.to_i)
  rescue ActiveRecord::RecordInvalid => errors
    Rails.logger.error errors.to_s
  end

  def tweet_to_twitter
    twitter_api.tweet(self)
  end

  def self.reply_to_the_stream(keyword)
    twitter_streaming_api.stream(keyword) { |tweet| reply_to_tweet(tweet, keyword) }
  end

  def self.reply_to_tweet(tweet, streaming_search_word)
    Rails.logger.info "Got a Tweet - Ref: #{tweet.id}, Text: #{tweet.text}"
    tweet_random_gif(get_keyword_from(tweet.dup, streaming_search_word), tweet.id.to_i, tweet.user.screen_name)
  end

  def self.get_keyword_from(tweet, streaming_search_word)
    tweet.text.gsub(/#?#{streaming_search_word}/, '').strip
  end

  def message
    replying_to_user_handle.blank? ? text : "@#{replying_to_user_handle} #{text}".strip
  end
end