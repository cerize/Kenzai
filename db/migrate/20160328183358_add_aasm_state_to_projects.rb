class AddAasmStateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :aasm_state, :string
    add_index  :projects, :aasm_state
  end
end
