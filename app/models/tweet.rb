class Tweet < ActiveRecord::Base
  include AASM

  validates :content, presence: true

  aasm do
    state :new, initial: true
  end
end
