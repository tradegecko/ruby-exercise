class Movie < ActiveRecord::Base
  has_many :analyses
  has_many :outcomes
  has_many :tweets

  validates_presence_of :title
  validates_uniqueness_of :title

  enum state: { inactive: 0, active: 1 }
end
