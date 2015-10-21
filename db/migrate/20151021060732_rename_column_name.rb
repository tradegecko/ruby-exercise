class RenameColumnName < ActiveRecord::Migration
  def change
    rename_column :answeredmentions, :tweetid, :tweet_id
  end
end
