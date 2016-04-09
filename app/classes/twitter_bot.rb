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

  def tweet message: nil
    message ||= Tweet.untweeted.last.content if Tweet.untweeted.last
    @client.update message if message
  end
end
