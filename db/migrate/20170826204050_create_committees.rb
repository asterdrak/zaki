class CreateCommittees < ActiveRecord::Migration[5.0]
  def change
    create_table :committees do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :committees, :name, unique: true
  end
end
