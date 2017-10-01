class AddCommitteeToTrial < ActiveRecord::Migration[5.0]
  def change
    execute 'DELETE FROM trials;'
    add_reference :trials, :committee, foreign_key: true, null: false
  end
end
