class AnalysisTweet < ActiveRecord::Base
  belongs_to :analysis
  belongs_to :tweet
end
