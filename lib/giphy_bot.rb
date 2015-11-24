class GiphyBot
  def self.tweet_random_gif(keyword)
    Rails.logger.info 'Starting tweet random gif task...'

    Tweet.tweet_random_gif(keyword)

    Rails.logger.info 'Finished tweeting a random gif.'
  end
end