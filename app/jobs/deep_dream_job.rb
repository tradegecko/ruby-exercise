class DeepDreamJob < ActiveJob::Base
  queue_as :default
  
  def perform
    # perform dreaming job later
    twitter_client = TwitterClient.new
    Rails.logger.info 'searching tweets....'
    results = twitter_client.search_tweets_with_images_by_keyword(ENV['DREAM_KEYWORD'])
    
    Rails.logger.info 'getting image....'
    original_media_url = results.first.media.first.media_url.to_s
    original_image_path = FileHandler.download_file_from_url original_media_url
    
    Rails.logger.info 'processing image....'
    dreamscopeapp_client = DreamscopeappClient.new(original_image_path.to_s)
    filter_image_url = dreamscopeapp_client.pull
    filter_image_path = FileHandler.download_file_from_url filter_image_url
    
    Rails.logger.info 'tweeting image....'
    twitter_client.tweet_dreamed_image("Deep dream", File.new(filter_image_path))
    Rails.logger.info 'new tweet completed!'
  end
end
