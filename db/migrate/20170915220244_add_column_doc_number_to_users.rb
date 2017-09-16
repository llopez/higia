class AddColumnDocNumberToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :doc_number, :integer
  end
end
