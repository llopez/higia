class AddColumnDocTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :doc_type, :string
  end
end
