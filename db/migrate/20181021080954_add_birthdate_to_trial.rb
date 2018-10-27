class AddBirthdateToTrial < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :birthdate, :date
  end
end
