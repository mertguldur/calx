class CreateAppAuthorizationResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :app_authorization_responses do |t|
      t.integer :app_authorization_request_id
      t.timestamps
    end
    add_index :app_authorization_responses, :app_authorization_request_id, name: "index_app_authorization_request_id"
    add_foreign_key :app_authorization_responses, :app_authorization_requests, column: :app_authorization_request_id, primary_key: :id
  end
end
