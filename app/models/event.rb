class Event < ApplicationRecord
  belongs_to :event_type

  before_save :ensure_present_title

  scope :starts_on, -> (date) { where(start_time: date.beginning_of_day..date.end_of_day) }
  scope :specific_time, -> { by_event_type('specific_time') }
  scope :any_time, -> { by_event_type('any_time') }
  scope :all_day, -> { by_event_type('all_day') }

  def self.list_for_date(date, user)
    events = where(user_id: user.id).starts_on(date).order(:start_time)
    events.all_day + events.specific_time + events.any_time
  end

  def self.upcoming(events, now)
    events.select do |event|
      event.specific_time? &&
        event.start_date == now.to_date &&
        event.start_time > now
    end.first
  end

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

  def self.by_event_type(event_type)
    where(event_type_id: EventType.find_by_event_type(event_type).id)
  end

  private

  def ensure_present_title
    self.title = 'Untitled' if title.blank?
  end
end
