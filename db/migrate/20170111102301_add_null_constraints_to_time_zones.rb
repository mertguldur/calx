class AddNullConstraintsToTimeZones < ActiveRecord::Migration[5.0]
  def change
    change_column :time_zones, :time_zone, :text, null: false
  end
end
