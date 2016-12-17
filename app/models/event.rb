class Event < ApplicationRecord
  validates :title, presence: true

  scope :starts_on, -> (date) { where(start_time: date.beginning_of_day..date.end_of_day) }
end
