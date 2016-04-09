class AddReplyToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :reply, :boolean, default: false
  end
end
