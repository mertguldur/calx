class CreateEventTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :event_types do |t|
      t.text :event_type
    end
    add_column :events, :event_type_id, :integer
    add_index :events, :event_type_id
    add_foreign_key :events, :event_types, columns: :event_type_id, primary_key: :id
  end
end
