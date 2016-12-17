class AddUserIdToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :user_id, :integer
    add_index :events, :user_id
    add_foreign_key :events, :users, column: :user_id, primary_key: :id
  end
end
