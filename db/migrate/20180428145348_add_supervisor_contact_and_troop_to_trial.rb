class AddSupervisorContactAndTroopToTrial < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :supervisor_phone_number, :string
    add_column :trials, :supervisor_email, :string
    add_column :trials, :troop, :string
  end
end
