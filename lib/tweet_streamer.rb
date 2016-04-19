require "open-uri"
require "securerandom"
require Rails.root.join("config", "environment")

TweetStream.configure do |conf|
  conf.consumer_key        = Rails.application.secrets.TWITTER_CONSUMER_KEY
  conf.consumer_secret     = Rails.application.secrets.TWITTER_CONSUMER_SECRET
  conf.oauth_token         = Rails.application.secrets.TWITTER_ACCESS_TOKEN
  conf.oauth_token_secret  = Rails.application.secrets.TWITTER_ACCESS_SECRET
  conf.auth_method         = :oauth
end

tweet_client = Twitter::REST::Client.new do |conf|
  conf.consumer_key        = Rails.application.secrets.TWITTER_CONSUMER_KEY
  conf.consumer_secret     = Rails.application.secrets.TWITTER_CONSUMER_SECRET
  conf.access_token        = Rails.application.secrets.TWITTER_ACCESS_TOKEN
  conf.access_token_secret = Rails.application.secrets.TWITTER_ACCESS_SECRET
end

twitter_handle = "@FindRandomFlick"
logger = nil
daemon = TweetStream::Daemon.new("tweet_streamer", {log_output: true, ontop: true})
daemon.on_inited do
  logger = Logger.new(Rails.root.join('log', 'stream.log'))
  Rails.logger = logger
end
daemon.track(twitter_handle) do |obj|
  tweet = obj.attrs
  logger.debug tweet

  tweet_message, image_file = nil, nil
  user = tweet[:user][:screen_name]
  if "@#{user}" != twitter_handle #preventing infinite loop
    search_request = tweet[:text].gsub(twitter_handle, "").strip

    begin
      photo_details = Flickr.search(search_request)

      logger.debug "Tweeting with Flick result: #{photo_details}"
      temp_file_name = SecureRandom.hex(10)

      # Download the flickr photo and upload the photo in tweet for maximum impact.
      # (Twitter does not allow uploading image from an URL)
      open(photo_details[:photo_url]) do |f|
        File.open("/tmp/#{temp_file_name}.jpg", "wb") { |file| file.puts f.read }
      end

      tweet_message = "@#{user} #{photo_details[:flickr_url]}. \"#{photo_details[:title]}\" -#{photo_details[:owner]}"
      image_file = File.new("/tmp/#{temp_file_name}.jpg")

    rescue StandardError => err
      logger.error(err.message)
      tweet_message = "@#{user} Couldn't find what you are looking for. How about some potatoes instead."
      image_file = File.new(Rails.root.join("lib", "potatoes.jpg"))
    end

    tweet_client.update_with_media(tweet_message, image_file, in_reply_to_status_id: tweet[:id])
  end

end
