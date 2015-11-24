class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.decimal :twitter_ref
      t.string :image_url
      t.string :text
      t.timestamps
    end

    add_index :tweets, :twitter_ref
  end
end
