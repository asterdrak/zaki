class AddRankToTrial < ActiveRecord::Migration[5.0]
  def change
    add_reference :trials, :rank, foreign_key: true
    Committee.all.each do |commitee|
      commitee.ranks.create(name: 'przewodnik') if commitee.ranks.empty?
      commitee.trials.update_all(rank_id: commitee.ranks.first.id)
    end
    change_column :trials, :rank_id, :integer, null: false
  end
end
