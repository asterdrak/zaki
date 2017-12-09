class CreateRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :ranks do |t|
      t.string :name, null: false
      t.references :committee, foreign_key: true, null: false

      t.timestamps
    end
  end
end
