class AddCommitteeIdToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :committee_id, :integer
    add_foreign_key :comments, :committees
  end
end
