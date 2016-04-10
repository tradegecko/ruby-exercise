class ChangeColumnsInMentions < ActiveRecord::Migration
  def change
    add_column :mentions, :screen_name, :string
    remove_column :mentions, :sender_twitter_id, :string
  end
end
