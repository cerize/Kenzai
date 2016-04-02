class ChangeColumnTypeOnSprints < ActiveRecord::Migration
  def change
    change_column :sprints, :start_date, 'timestamp USING start_date::timestamp'
    change_column :sprints, :end_date, 'timestamp USING end_date::timestamp'
  end
end
