class AddStatemanTrialIdToTrial < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :stateman_trial_id, :string
  end
end
