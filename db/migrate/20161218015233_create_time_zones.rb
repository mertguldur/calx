class CreateTimeZones < ActiveRecord::Migration[5.0]
  def change
    create_table :time_zones do |t|
      t.text :time_zone
    end
    add_column :users, :time_zone_id, :integer
    add_index :users, :time_zone_id
    add_foreign_key :users, :time_zones, column: :time_zone_id, primary_key: :id
  end
end
