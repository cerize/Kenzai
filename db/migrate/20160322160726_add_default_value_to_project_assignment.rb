class AddDefaultValueToProjectAssignment < ActiveRecord::Migration
  def change
    change_column_default :project_assignments, :is_manager, false
  end
end
