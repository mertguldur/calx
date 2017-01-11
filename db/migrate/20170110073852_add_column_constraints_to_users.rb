class AddColumnConstraintsToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :email, :string, null: false, limit: 500
    change_column :users, :password_digest, :text, null: false
    change_column :users, :time_zone_id, :integer, null: false
  end
end
