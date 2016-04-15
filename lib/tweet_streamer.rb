require "open-uri"
require "securerandom"
root = File.expand_path(File.join(File.dirname(__FILE__), ".."))
require File.join(root, "config", "environment")

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
TweetStream::Daemon.new("tweet_streamer", {log_output: true, ontop: true}).track(twitter_handle) do |obj|
  tweet = obj.attrs
  user = tweet[:user][:screen_name]
  if "@#{user}" != twitter_handle #preventing infinite loop
    search_request = tweet[:text].gsub(twitter_handle, "").strip

    begin
      photo_details = Flickr.search(search_request)
      temp_file_name = SecureRandom.hex(10)

      open(photo_details[:photo_url]) do |f|
        File.open("/tmp/#{temp_file_name}.jpg", "wb") { |file| file.puts f.read }
      end

      tweet_client.update_with_media(
      "@#{user} #{photo_details[:flickr_url]}",
      File.new("/tmp/#{temp_file_name}.jpg"),
      in_reply_to_status_id: tweet[:id])
    rescue
      tweet_client.update_with_media(
      "@#{user} Couldn't find what you are looking for. How about some potatoes instead.",
      File.new(File.join(root, "lib", "potatoes.jpg")),
      in_reply_to_status_id: tweet[:id])
    end
  end

end
