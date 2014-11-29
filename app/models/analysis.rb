class Analysis < ActiveRecord::Base
  belongs_to :movie
  has_many :analysis_tweets
  has_many :tweets, through: :analysis_tweets
end
