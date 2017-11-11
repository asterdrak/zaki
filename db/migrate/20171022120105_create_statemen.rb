class CreateStatemen < ActiveRecord::Migration[5.0]
  def change
    create_table :statemen do |t|
      t.string :organization_id, null: false
      t.belongs_to :committee, foreign_key: true, null: false
      t.boolean :trials_created, null: false, default: false
      t.boolean :tasks_created, null: false, default: false

      t.timestamps
    end
  end
end
