class AddAasmStateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :aasm_state, :string
    add_index  :tasks, :aasm_state
  end
end
