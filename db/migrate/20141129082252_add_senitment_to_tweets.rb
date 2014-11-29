class AddSenitmentToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :sentiment, :integer, default: 0
  end
end
