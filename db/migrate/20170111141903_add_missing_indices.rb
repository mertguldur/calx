class AddMissingIndices < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :email, unique: true
    add_index :users, :remember_digest, unique: true
    add_index :time_zones, :time_zone, unique: true
    add_index :tenants, :access_id, unique: true
    add_index :events, :start_time
    add_index :event_types, :event_type, unique: true
    add_index(:app_authorization_response_types,
              :app_authorization_response_type,
              unique: true,
              name: 'index_response_types_on_app_authorization_response_type')
  end
end
