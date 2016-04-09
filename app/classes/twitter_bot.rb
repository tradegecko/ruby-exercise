class TwitterBot
  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['consumer_key']
      config.consumer_secret     = ENV['consumer_secret']
      config.access_token        = ENV['access_token']
      config.access_token_secret = ENV['access_token_secret']
    end
  end

  def tweet
    return unless Tweet.untweeted.last
    @client.update Tweet.untweeted.last.content
    Tweet.untweeted.last.tweet!
  end
end
