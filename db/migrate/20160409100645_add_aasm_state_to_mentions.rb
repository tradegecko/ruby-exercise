class AddAasmStateToMentions < ActiveRecord::Migration
  def change
    add_column :mentions, :aasm_state, :string
  end
end
