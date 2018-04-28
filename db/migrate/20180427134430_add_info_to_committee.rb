class AddInfoToCommittee < ActiveRecord::Migration[5.0]
  def change
    add_column :committees, :info, :text
  end
end
