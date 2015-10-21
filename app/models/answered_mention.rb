class AnsweredMention < ActiveRecord::Base
  validates :tweet_id, presence: true
end
