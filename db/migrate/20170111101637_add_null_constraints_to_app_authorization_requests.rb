class AddNullConstraintsToAppAuthorizationRequests < ActiveRecord::Migration[5.0]
  def change
    change_column :app_authorization_requests, :tenant_id, :integer, null: false
    change_column :app_authorization_requests, :user_id, :integer, null: false
  end
end
