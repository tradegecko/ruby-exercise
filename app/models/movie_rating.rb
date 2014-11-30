class MovieRating

  attr_accessor :movie, :outcomes

  def initialize(movie)
    @movie = Movie.where(id: movie.id).includes(:outcomes).first
    @outcomes = @movie.outcomes
  end

  def overall_rating
    calculate_average(@outcomes)
  end

  def average_ratings_by_day
    average_ratings(:day)
  end

  def average_ratings_by_week
    average_ratings(:week)
  end

  def average_ratings_by_month
    average_ratings(:month)
  end

  def average_ratings_by_year
    average_ratings(:year)
  end

  private

  def average_ratings(time_unit = :day)
    @outcomes.group_by(&time_unit).map do |unit, group|
      { time_unit => unit, :rating => calculate_average(group) }
    end 
  end

  def calculate_average(outcomes)
    total_sum = outcomes.map(&:rating).reduce(:+)
    total_count = outcomes.count.to_f
    (total_sum / total_count).round(2)
  end
end
