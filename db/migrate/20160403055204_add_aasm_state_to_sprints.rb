class AddAasmStateToSprints < ActiveRecord::Migration
  def change
    add_column :sprints, :aasm_state, :string
    add_index  :sprints, :aasm_state
  end
end
