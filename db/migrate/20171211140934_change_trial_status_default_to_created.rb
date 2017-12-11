class ChangeTrialStatusDefaultToCreated < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:trials, :status, 'created')
  end
end
