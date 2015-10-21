class RenameTableName < ActiveRecord::Migration
  def change
    rename_table :answeredmentions, :answered_mentions
  end
end
