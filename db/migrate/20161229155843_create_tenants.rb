class CreateTenants < ActiveRecord::Migration[5.0]
  def change
    create_table :tenants do |t|
      t.text :access_id
      t.text :secret_key
      t.timestamps
    end
  end
end
