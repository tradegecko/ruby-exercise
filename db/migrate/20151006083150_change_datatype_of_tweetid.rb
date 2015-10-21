class ChangeDatatypeOfTweetid < ActiveRecord::Migration
  def change 
    change_table :answeredmentions do |t|
      t.change :tweetid, :bigint
    end
  end
end
