class AddPrivateKeyToTrial < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :private_key_digest, :string
    add_index :trials, :private_key_digest, unique: true
  end
end
