class AddIsAdminToProjectAssignment < ActiveRecord::Migration
  def change
    add_column :project_assignments, :is_manager, :boolean
  end
end
