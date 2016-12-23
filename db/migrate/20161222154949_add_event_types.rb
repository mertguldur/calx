class AddEventTypes < ActiveRecord::Migration[5.0]
  def change
    %w(specific_time any_time all_day).each do |event_type|
      EventType.create!(event_type: event_type)
    end
  end
end
