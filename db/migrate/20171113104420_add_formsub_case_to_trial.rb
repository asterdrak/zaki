class AddFormsubCaseToTrial < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :formsub_case_id, :string
    add_column :trials, :formsub_case_keyword, :string
  end
end
