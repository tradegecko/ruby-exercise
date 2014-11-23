class CreateCheckHistories < ActiveRecord::Migration
  def change
    create_table :check_histories do |t|
      t.string :last_id_checked

      t.timestamps
    end
  end
end
