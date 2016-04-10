class AddMentionIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :mention_id, :integer
  end
end
