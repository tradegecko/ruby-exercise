class RenameTweetIdToTwitterRefInTweets < ActiveRecord::Migration
  def change
    rename_column :tweets, :tweet_id, :twitter_ref
  end
end
