class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.string :title
      t.text :description
      t.string :start_date
      t.string :end_date
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
