class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :author
      t.text :content
      t.string :hashtags

      t.timestamps
    end
  end
end
