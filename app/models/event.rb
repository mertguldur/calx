class Event < ApplicationRecord
  belongs_to :event_type

  validates :title, presence: true

  scope :starts_on, -> (date) { where(start_time: date.beginning_of_day..date.end_of_day) }

  def start_date
    start_time&.to_date
  end

  def end_date
    end_time&.to_date
  end

  def specific_time?
    event_type&.event_type == 'specific_time'
  end

  def any_time?
    event_type&.event_type == 'any_time'
  end

  def all_day?
    event_type&.event_type == 'all_day'
  end
end
