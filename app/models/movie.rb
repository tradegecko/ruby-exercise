class Movie < ActiveRecord::Base
  validates_presence_of :title

  def self.analyze_all
    results = []
    all.each { |movie| results << {movie: movie, result: Sentwix.analyze_movie(movie.title)} }
    results
  end
end
