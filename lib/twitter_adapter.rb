class TwitterAdapter
  attr_reader :client
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "qQ9i0OO0DTDlp90vU7amaF5lt"
      config.consumer_secret     = "vlMhOLkjOSw5kOVBwcQKZq4cicC8uqbXSFcYycw7fmjERabbsi"
    end
  end

  def tweet(message)
    client.update(message)
  end
end
