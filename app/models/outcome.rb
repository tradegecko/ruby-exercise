class Outcome < ActiveRecord::Base
  belongs_to :movie
  belongs_to :analysis

  def set_time_dimensions
    { 
      'day' => '%j',
      'week' => '%U',
      'month' => '%m',
      'year' => '%Y'
    }.each do |method, arg|
      send("#{method}=", self.created_at.strftime(arg).to_i)
    end 
    self
  end
  
  def set_rating
    score = analysis.weighted_average
    # Map score=>[-1,1] to rating=>[1,5], using f(x)=2x+3
    self.rating = (2*score) + 3
  end

  def refresh
    set_time_dimensions
    set_rating
    save!
  end
end
