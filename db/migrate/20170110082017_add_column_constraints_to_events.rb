class AddColumnConstraintsToEvents < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :title, :string, null: false, limit: 500
    change_column :events, :start_time, :datetime, null: false
    change_column :events, :end_time, :datetime, null: false
    change_column :events, :notes, :string, limit: 10_000
    change_column :events, :user_id, :integer, null: false
    change_column :events, :event_type_id, :integer, null: false
  end
end
