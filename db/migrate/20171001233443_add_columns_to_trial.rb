class AddColumnsToTrial < ActiveRecord::Migration[5.0]
  def change
    execute 'DELETE FROM trials;'
    add_column :trials, :deadline, :date, null: false
    add_column :trials, :status, :string, default: 'pending', null: false
  end
end
