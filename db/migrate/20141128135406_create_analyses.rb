class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.integer :movie_id
      t.integer :positive
      t.integer :neutral
      t.integer :negative
      t.timestamps
    end
  end
end
