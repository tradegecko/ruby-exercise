class RobotsController < ApplicationController
  def index
    @movie = Movie.new
    @movies = Movie.all
    @tweets = Tweet.all
  end
end
