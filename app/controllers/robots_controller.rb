class RobotsController < ApplicationController
  def index
    @movie = Movie.new
    @movies = Movie.active
    @tweets = Tweet.all
  end
end
