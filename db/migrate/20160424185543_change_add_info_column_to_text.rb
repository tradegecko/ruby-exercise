class ChangeAddInfoColumnToText < ActiveRecord::Migration
  def change
    change_column :poke_quizzes, :addinfo, :text, :limit => nil
  end
end
