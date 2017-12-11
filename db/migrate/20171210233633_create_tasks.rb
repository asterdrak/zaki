class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.integer :number, null: false
      t.belongs_to :trial, foreign_key: true, null: false
      t.text :content, null: false
      t.datetime :deadline, null: false

      t.timestamps
    end
  end
end
