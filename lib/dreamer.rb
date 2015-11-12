# Save photos from tweets and retweet their dream photos
class Dreamer
  TWEET_LENGTH = 116
  private_class_method :new
  attr_reader :keyword

  def self.dream(keyword)
    new(keyword).tweet
  end

  def initialize(keyword)
    @client = TwitterApi.new
    @keyword = keyword
  end

  def tweet
    @client.tweet(message,
                  dream_image.image.versions[:dream].file.to_file,
                  dream_image.twitter_id)
  end

  private

  def dream_image
    @dream_image ||= begin
      fail('Nothing to dream at the moment.') unless tweet_with_image
      DreamImage.create! twitter_id: tweet_with_image.id,
                         remote_image_url: tweet_with_image.media.first.media_url.to_s,
                         user: tweet_with_image.user.screen_name,
                         text: tweet_with_image.text
    end
  end

  def message
    # TODO: Refactor into separate model (e.g. tweet composer)
    s = "RT @#{dream_image.user} #{dream_image.text}"
    ActiveSupport::Multibyte::Chars.new(s).normalize(:c)[0...TWEET_LENGTH]
  end

  def tweet_with_image
    @tweet_with_image ||= begin
      @client.find_tweets_with_images_by_keyword(keyword).find do |tweet|
        !DreamImage.exists?(twitter_id: tweet.id) \
          && tweet.media.first.present?
      end
    end
  end
end
