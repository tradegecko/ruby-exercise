class RobotsController < ApplicationController
  def index
  end

  def send_weather
  	client = TwitterClient.new
  	client.post_tweet
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

end
