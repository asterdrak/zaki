class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :email
      t.string :status

      t.timestamps
    end
  end
end
