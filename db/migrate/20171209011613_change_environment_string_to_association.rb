class ChangeEnvironmentStringToAssociation < ActiveRecord::Migration[5.0]
  def change
    Trial.all.update_all(environment: nil)
    rename_column :trials, :environment, :environment_id
    change_column :trials, :environment_id, :integer, using: 'environment_id::integer'
    add_foreign_key :trials, :environments

    Committee.all.each do |commitee|
      commitee.environments.create(name: 'hufiec') if commitee.environments.empty?
      commitee.trials.update_all(environment_id: commitee.environments.first.id)
    end

    change_column :trials, :environment_id, :integer, null: false
  end
end
