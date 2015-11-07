class CreateDreamImages < ActiveRecord::Migration
  def change
    create_table :dream_images do |t|
      t.integer :twitter_id, :limit => 8
      t.string :image
      t.string :user
      t.string :text
      t.string :result

      t.timestamps
    end
    add_index :dream_images, :twitter_id
  end
end
