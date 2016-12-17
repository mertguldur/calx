class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.text :title
      t.datetime :start_time
      t.datetime :end_time
      t.text :notes
    end
  end
end
