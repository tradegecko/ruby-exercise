class CreateOutcomes < ActiveRecord::Migration
  def change
    create_table :outcomes do |t|
      t.integer :movie_id
      t.integer :analysis_id
      t.integer :year
      t.integer :month
      t.integer :week
      t.integer :day
      t.float :rating
      t.timestamps
    end
  end
end
