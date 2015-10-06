class Answeredmention < ActiveRecord::Base
  validates :tweetid, presence: true
end
