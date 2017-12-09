class CreateEnvironments < ActiveRecord::Migration[5.0]
  def change
    create_table :environments do |t|
      t.string :name, null: false
      t.string :supervisor_name
      t.string :supervisor_email
      t.boolean :notify_supervisor
      t.references :committee, foreign_key: true, null: false

      t.timestamps
    end
  end
end
