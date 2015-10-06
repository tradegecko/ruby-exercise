class CreateAnsweredmentions < ActiveRecord::Migration
  def change
    create_table :answeredmentions do |t|
      t.integer :tweetid

      t.timestamps
    end
  end
end
