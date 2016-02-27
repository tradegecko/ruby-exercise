class Quote < ActiveRecord::Base
  validates :content, presence: true
end
