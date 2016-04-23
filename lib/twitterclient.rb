require 'twitter'

# Use the sample code in https://github.com/vigneshwaranr/python-oauth2 to quickly
# authorize and generate access tokens for any twitter accounts for your app
# Above is a fork with minor changes to get it working.
# Full credits goes to the original developer.
class TwitterClient

  def self.[](sym)
    return unless sym.is_a? Symbol
    all[sym] ||= self.create(sym.to_s.upcase)
  end

  def self.all
    @@clients ||= Hash.new
  end

  
  class << self
    protected
    def create key
      puts "Creating client for #{key}"
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_#{key}_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_#{key}_ACCESS_TOKEN_SECRET"]
      end
    end
  end

end