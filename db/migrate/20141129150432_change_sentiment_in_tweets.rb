class ChangeSentimentInTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :sentiment
    add_column :tweets, :sentiment, :integer
  end
end
