class CreateUserStories < ActiveRecord::Migration
  def change
    create_table :user_stories do |t|
      t.string :title
      t.text :description
      t.references :sprint, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
