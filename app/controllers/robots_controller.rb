class RobotsController < ApplicationController
  def index
    @movie = Movie.new
    @movies = Movie.all
  end
end
