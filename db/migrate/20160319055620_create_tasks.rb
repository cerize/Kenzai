class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :start_date
      t.string :end_date
      t.references :sprint, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
