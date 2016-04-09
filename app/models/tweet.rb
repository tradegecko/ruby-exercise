class Tweet < ActiveRecord::Base
  include AASM

  validates :content, presence: true

  scope :untweeted, -> { where.not(aasm_state: 'tweeted') }

  aasm do
    state :new, initial: true
    state :tweeted

    event :tweet do
      transitions from: :new, to: :tweeted
    end
  end
end
