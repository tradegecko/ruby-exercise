class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.column :mention_id, :bigint
      t.string :reply_to
      t.string :mentioned_user
      t.string :status, default: "unreplied"
      t.timestamps
    end
  end
end
