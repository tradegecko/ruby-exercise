class TwitterAdapter
  attr_reader :client
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "qQ9i0OO0DTDlp90vU7amaF5lt"
      config.consumer_secret     = "vlMhOLkjOSw5kOVBwcQKZq4cicC8uqbXSFcYycw7fmjERabbsi"
      config.access_token        = "505630624-zFJ3erkF4gaeS4o6G9GT9vYHl8WiWG9iIDUVj60s"
      config.access_token_secret = "Tw79CRa97qWpFYLBCs6dfIlh1bhwIOWNFGyWV0yi7YRMC"
    end
  end

  def tweet(message)
    client.update(message)
  end
end
