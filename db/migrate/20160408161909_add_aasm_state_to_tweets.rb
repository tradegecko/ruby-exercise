class AddAasmStateToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :aasm_state, :string
  end
end
