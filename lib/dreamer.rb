# Save photos from tweets and retweet their dream photos
class Dreamer
  private_class_method :new
  attr_reader :keyword

  def self.dream(keyword)
    new(keyword).dream
  end

  def initialize(keyword)
    @client = TwitterApi.new
    @keyword = keyword
  end

  def dream
    dream_image = image_to_dream(keyword)
    @client.tweet("RT @#{dream_image.user} #{dream_image.text}"[0...116],
                  dream_image.image.versions[:dream].file.to_file,
                  dream_image.twitter_id)
  end

  private

  def image_to_dream(keyword)
    if (tweet = find_tweet_with_image(keyword))
      DreamImage.create! twitter_id: tweet.id.to_s,
                         remote_image_url: tweet.media.first.media_url.to_s,
                         user: tweet.user.screen_name,
                         text: tweet.text
    else
      Rails.logger.info 'Nothing to dream at the moment.' && return
    end
  end

  def find_tweet_with_image(keyword)
    @client.find_tweets_with_images_by_keyword(keyword).find do |tweet|
      !DreamImage.exists?(twitter_id: tweet.id.to_s) \
        && tweet.media.first.present?
    end
  end
end
