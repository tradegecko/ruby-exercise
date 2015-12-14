class DeepDreamJob < ActiveJob::Base
  queue_as :default
  
  def perform
    @results = fetch_tweets
    @original_image_path = fetch_image
    @filter_image_path = process_image
    status = compose_tweet

    tweet = tweet_image(status)

    if tweet
      Rails.logger.info 'new tweet sent!'
    else 
      Rails.logger.info 'failed sending tweet! :('
    end
  end

  private 

  def fetch_tweets
    twitter_client = TwitterClient.new
    results = twitter_client.search_tweets_with_images_by_keyword(ENV['DREAM_KEYWORD'])
  end

  def fetch_image
    original_media_url = @results.first.media.first.media_url.to_s
    original_image_path = FileHandler.download_file_from_url original_media_url
  end

  def process_image
    @dreamscopeapp_client = DreamscopeappClient.new(@original_image_path.to_s)
    filter_image_url = @dreamscopeapp_client.pull
    filter_image_path = FileHandler.download_file_from_url filter_image_url
  end

  def compose_tweet 
    status = TweetComposer.compose_dream_tweet(@results.first, @dreamscopeapp_client.filter)
  end 

  def tweet_image status
    tweet = twitter_client.tweet_dreamed_image(status, File.new(@filter_image_path))
  end
end
