class Mention < ActiveRecord::Base
  include AASM
  has_many :tweets

  after_create :analyze!

  aasm do
    state :unanalyzed, initial: true
    state :analyzed, before_enter: :perform_analysis, after_enter: :reply!
    state :replied, before_enter: :prepare_reply

    event :analyze do
      transitions from: :unanalyzed, to: :analyzed
    end

    event :reply do
      transitions from: :analyzed, to: :replied
    end
  end

  private

  def perform_analysis
    # perform some kind of analysis here
    self.reply_content = "I don't know what to say"
  end

  def prepare_reply
    self.tweets.create(content: self.reply_content, reply: true)
  end
end
