class CreateStartupTags < ActiveRecord::Migration
  def change
    create_table :startup_tags do |t|
      t.integer :angel_id, null: false
      t.string :name
      t.integer :children
      t.integer :result_pages, default: 1

      t.timestamps
    end
  end
end
