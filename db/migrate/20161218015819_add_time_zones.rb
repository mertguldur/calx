class AddTimeZones < ActiveRecord::Migration[5.0]
  def change
    ActiveSupport::TimeZone.all.map(&:name).each do |time_zone|
      TimeZone.create!(time_zone: time_zone)
    end
  end
end
