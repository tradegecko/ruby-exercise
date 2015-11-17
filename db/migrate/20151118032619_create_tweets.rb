class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.decimal :tweet_id
      t.string :image_url
      t.string :text
      t.timestamps
    end

    add_index :tweets, :tweet_id
  end
end
