class AddNullConstraintsToAppAuthorizationResponseTypes < ActiveRecord::Migration[5.0]
  def change
    change_column :app_authorization_response_types, :app_authorization_response_type, :text, null: false
  end
end
