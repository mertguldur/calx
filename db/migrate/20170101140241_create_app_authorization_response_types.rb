class CreateAppAuthorizationResponseTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :app_authorization_response_types do |t|
      t.text :app_authorization_response_type
    end
    add_column :app_authorization_responses, :app_authorization_response_type_id, :integer
    add_index :app_authorization_responses, :app_authorization_response_type_id, name: 'app_authorization_response_type_id'
    add_foreign_key :app_authorization_responses, :app_authorization_response_types, column: :app_authorization_response_type_id, primary_key: :id
  end
end
