class Mention < ActiveRecord::Base

  validates :mention_id, presence: true, uniqueness: true
  validates :reply_to, :mentioned_user, presence: true

  scope :unreplied_mentions, -> { where(status: "unreplied") }

  # Saves a mention property if not yet existing in Mentions table
  # default status: unreplied
  def self.save_mention(mention)
    find_or_create_by(mention_id: mention.id) do |attr|
      attr.mention_id = mention.id
      attr.reply_to = mention.user.screen_name
      attr.mentioned_user = mention.user_mentions.last.name
    end
  end

end
