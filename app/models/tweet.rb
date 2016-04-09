class Tweet < ActiveRecord::Base
  include AASM

  validates :content, presence: true

  aasm do
    state :untweeted, initial: true
    state :tweeted

    event :tweet do
      transitions from: :untweeted, to: :tweeted
    end
  end
end
