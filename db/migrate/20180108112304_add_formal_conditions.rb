class AddFormalConditions < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :formal_conditions, :boolean, default: false, null: false
    add_column :committees, :formal_conditions, :text
  end
end
