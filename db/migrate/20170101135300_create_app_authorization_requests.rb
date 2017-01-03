class CreateAppAuthorizationRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :app_authorization_requests do |t|
      t.integer :tenant_id
      t.integer :user_id
      t.timestamps
    end

    add_index :app_authorization_requests, :tenant_id
    add_index :app_authorization_requests, :user_id

    add_foreign_key :app_authorization_requests, :tenants, column: :tenant_id, primary_key: :id
    add_foreign_key :app_authorization_requests, :users, column: :user_id, primary_key: :id
  end
end
