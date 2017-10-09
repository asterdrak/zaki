class AddColumns2ToTrial < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :email, :string
    add_column :trials, :phone_number, :string
    add_column :trials, :supervisor, :string
    add_column :trials, :environment, :string
    change_column :trials, :deadline, :date, :null => true
  end
end
