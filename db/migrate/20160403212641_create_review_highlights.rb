class CreateReviewHighlights < ActiveRecord::Migration
  def change
    create_table :review_highlights do |t|
      t.text :description
      t.references :sprint, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
