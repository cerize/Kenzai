class AddActualEndDateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :actual_end_date, :datetime
  end
end
