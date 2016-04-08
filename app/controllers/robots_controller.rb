class RobotsController < ApplicationController
  def index
  end

  def send_weather
  	client = TwitterClient.new
  	result = request_ip
  	client.post_tweet(result)
  	redirect_to weather_send_path
  end

  def random_send_weather
  	client = TwitterClient.new
  	client.random_post_tweet
  	redirect_to random_weather_send_path
  end

  def weather_send
  end

  def random_weather_send
  end

  private

  def request_ip
  	if Rails.env.development?
      return 'Singapore'
    else
      request.remote_ip
    end 
  end

end
