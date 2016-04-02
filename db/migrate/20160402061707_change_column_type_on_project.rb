class ChangeColumnTypeOnProject < ActiveRecord::Migration
  def change
    change_column :projects, :start_date, 'timestamp USING start_date::timestamp'
    change_column :projects, :end_date, 'timestamp USING end_date::timestamp'
  end
end
