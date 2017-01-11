class AddColumnConstraintsToTenants < ActiveRecord::Migration[5.0]
  def change
    change_column :tenants, :access_id, :string, null: false, limit: 500
    change_column :tenants, :secret_key, :text, null: false
  end
end
