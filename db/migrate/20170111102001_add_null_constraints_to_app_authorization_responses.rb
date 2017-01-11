class AddNullConstraintsToAppAuthorizationResponses < ActiveRecord::Migration[5.0]
  def change
    change_column :app_authorization_responses, :app_authorization_request_id, :integer, null: false
    change_column :app_authorization_responses, :app_authorization_response_type_id, :integer, null: false
  end
end
