class AddPendingChangesToTrial < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :pending_changes, :boolean, default: false, null: false
  end
end
