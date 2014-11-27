class Tweet < ActiveRecord::Base
  validates_presence_of :text
  validates_presence_of :created_at
end
