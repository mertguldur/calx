class AddNullConstraintsToEventTypes < ActiveRecord::Migration[5.0]
  def change
    change_column :event_types, :event_type, :text, null: false
  end
end
