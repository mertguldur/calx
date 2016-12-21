class Event < ApplicationRecord
  validates :title, presence: true

  scope :starts_on, -> (date) { where(start_time: date.beginning_of_day..date.end_of_day) }

  def start_date
    start_time&.to_date
  end

  def end_date
    end_time&.to_date
  end
end
