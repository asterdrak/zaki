class AddMinTrialTasksCountToCommittee < ActiveRecord::Migration[5.0]
  def change
    add_column :committees, :min_trial_tasks_count, :integer, default: 5, null: false
  end
end
