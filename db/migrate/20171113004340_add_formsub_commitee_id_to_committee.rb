class AddFormsubCommiteeIdToCommittee < ActiveRecord::Migration[5.0]
  def change
    add_column :committees, :formsub_committee_id, :string
  end
end
