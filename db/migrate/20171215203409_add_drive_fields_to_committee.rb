class AddDriveFieldsToCommittee < ActiveRecord::Migration[5.0]
  def change
    add_column :committees, :drive_token, :string
    add_column :committees, :drive_root, :string
  end
end
