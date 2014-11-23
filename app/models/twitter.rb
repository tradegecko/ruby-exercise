require 'twitter'
require 'yaml'

# Interface to access Twitter's REST API
class Twitter

  def initialize
    # Load keys and tokens from config.yml
    keys = YAML.load(File.read('config/twitter.yml'))

    begin
      # Create the REST client object for @colormyhex
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = keys['consumer_key']
        config.consumer_secret     = keys['consumer_secret']
        config.access_token        = keys['access_token']
        config.access_token_secret = keys['access_token_secret']
      end
    rescue Exception => details
      #log exception
      Rails.logger.fatal "Failed to load the client: #{details}"
    end

  end

end
