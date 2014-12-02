class RobotsController < ApplicationController
  def index
    @movie = Movie.new
    @movies = Movie.active
    @movie_ratings = @movies.map{|movie| MovieRating.new(movie)}
  end
end
