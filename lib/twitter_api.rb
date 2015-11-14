require 'twitter'

class TwitterApi

  def initialize
    @client = init_client
  end

  def find_tweets_with_images_by_keyword(keyword)
    @client.search(keyword_with_images(keyword), result_type: 'recent').take(100)
  end

  def tweet(message, media, in_reply_to_status_id)
    @client.update_with_media(message,
                              media,
                              {in_reply_to_status_id: in_reply_to_status_id})
  end

  private

  def keyword_with_images(keyword)
    [keyword, '-RT', 'filter:images'].join(' ')
  end

  def init_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret = Rails.application.secrets.twitter_consumer_secret
      config.access_token = Rails.application.secrets.twitter_access_token
      config.access_token_secret = Rails.application.secrets.twitter_access_token_secret
    end
  end
end
