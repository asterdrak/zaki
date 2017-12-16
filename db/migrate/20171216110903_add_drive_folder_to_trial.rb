class AddDriveFolderToTrial < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :drive_folder, :string
  end
end
