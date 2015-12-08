require 'giphy'

class GiphyApi

  def initialize
    Giphy::Configuration.configure do |config|
      config.api_key = Rails.application.secrets.giphy_api_key
    end
  end

  def fetch_random_gif(keyword=nil)
    Giphy.random(keyword).image_url
  rescue TypeError
    nil
  end
end