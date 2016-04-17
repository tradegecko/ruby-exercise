class Twitterbot 
  require 'twitter'

  #Post is a local method that serch for tweet with hastag #sad.
  #The method will favorite the tweet and post a respond to the user.
  def post
    twitter_client.search("#sad").take(1).each do |tweet|
        puts "#{tweet.user.screen_name}: #{tweet.text}"
        twitter_client.favorite(tweet)
        twitter_client.update("@#{tweet.user.screen_name} Happiness is the art of never holding in your mind the memory of any unpleasant thing that has passed.")
    end
  end

  private

  #twitter_clinet is a method define to access Twitter API.
  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret  = ENV["TWITTER_CONSUMER_SECRET"]
      config.oauth_token  = ENV["TWITTER_OAUTH_TOKEN"]
      config.oauth_token_secret = ENV["TWITTER_OAUTH_TOKEN_SECRET"]
    end
  end
  
end
