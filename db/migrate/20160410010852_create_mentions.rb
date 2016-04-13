class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.string   :tweet_id, null: false, unique: true  #bigint doesn't work here :o
      t.boolean  :answered, default: false
      t.timestamps null: false
    end
  end
end