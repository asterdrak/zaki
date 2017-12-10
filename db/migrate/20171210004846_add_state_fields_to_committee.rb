class AddStateFieldsToCommittee < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :stateman_state_id_cached, :integer
    add_column :committees, :overdue_state_id, :integer
    add_column :committees, :positive_finish_state_id, :integer
    add_column :committees, :negative_finish_state_id, :integer
  end
end
