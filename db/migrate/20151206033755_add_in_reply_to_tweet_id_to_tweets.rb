class AddInReplyToTweetIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :in_reply_to_tweet_id, :decimal
  end
end
