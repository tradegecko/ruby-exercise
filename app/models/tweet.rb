class Tweet < ActiveRecord::Base
  has_many :analysis_tweets
  has_many :analyses, through: :analysis_tweets
  belongs_to :movie

  validates_presence_of :object

  enum sentiment: { positive: 1, neutral: 0, negative: -1 }
end
