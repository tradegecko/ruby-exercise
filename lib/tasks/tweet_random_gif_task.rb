module Tasks
  class TweetRandomGifTask
    def self.run
      Rails.logger.info 'Starting tweet random gif task...'

      gif_url = GiphyApi.new.fetch_random_gif
      file = HttpHelper.download_file(gif_url)
      tweet = TwitterApi.new.tweet(nil,File.new(file.path))
      Tweet.create!(tweet_id: tweet.id.to_i, image_url: gif_url.to_s)

      Rails.logger.info 'Finished tweeting a random gif.'
    end
  end
end