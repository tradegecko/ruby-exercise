class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.string :tweet_id
      t.string :tweet
      t.string :tweet_by
      t.string :mentioned_startup
      t.boolean :replied, default: false
      t.boolean :replied_startup
      t.timestamps
    end
  end
end
