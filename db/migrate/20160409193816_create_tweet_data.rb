class CreateTweetData < ActiveRecord::Migration
  def change
    create_table :tweet_data do |t|
      t.string :content
      t.string :hashtag

      t.timestamps
    end
  end
end
