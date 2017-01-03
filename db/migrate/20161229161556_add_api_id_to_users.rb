class AddApiIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :api_id, :text, null: false
    add_index :users, :api_id, unique: true
  end
end
