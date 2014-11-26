module Sentwix
  class TwitterWrapper

    API_KEYS = {
      consumer_key: ENV['TWITTER_API_KEY'],
      consumer_secret: ENV['TWITTER_API_SECRET'],
      access_token: ENV['TWITTER_ACCESS_TOKEN'],
      access_token_secret: ENV['TWITTER_ACCESS_TOKEN_SECRET']
    }

    def initialize
      @client = Twitter::REST::Client.new do |config|
        API_KEYS.each do |method, value|
          config.send "#{method.to_s}=".to_sym, value
        end
      end
    end
    
    def search(topic, options={})
      return nil if topic.nil? || topic.strip.eql?("")
      @client.search(topic, options)
    end
    
  end
end
