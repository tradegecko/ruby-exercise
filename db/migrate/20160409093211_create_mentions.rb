class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.string :content
      t.string :sender_twitter_id
      t.string :mention_tweet_id
      t.string :reply_content

      t.timestamps
    end
  end
end
