class ChangeColumnTypeOnTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :start_date, 'timestamp USING start_date::timestamp'
    change_column :tasks, :end_date, 'timestamp USING end_date::timestamp'
  end
end
