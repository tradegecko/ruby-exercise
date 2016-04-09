class Tweet < ActiveRecord::Base
  include AASM

  belongs_to :mention

  validates :content, presence: true

  scope :unsent, ->{ untweeted.where(reply: false) }
  scope :unreplied, ->{ untweeted.where(reply: true) }

  aasm do
    state :untweeted, initial: true
    state :tweeted, before_enter: :update_tweeted_on

    event :tweet do
      transitions from: :untweeted, to: :tweeted
    end
  end

  def update_tweeted_on
    self.tweeted_on = Time.now
  end
end
