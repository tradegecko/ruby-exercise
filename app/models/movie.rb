class Movie < ActiveRecord::Base
  has_many :analyses
  has_many :tweets

  validates_presence_of :title
  validates_uniqueness_of :title

  enum state: { inactive: 0, active: 1 }

  def self.analyze_all
    results = []
    all.each do |movie|
      results << {
        movie: movie,
        result: Sentwix.analyze_movie(movie.title)
      }
    end
    results
  end
end
