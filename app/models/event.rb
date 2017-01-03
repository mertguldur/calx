class Event < ApplicationRecord
  lookup_for :event_type, symbolize: true

  before_save :ensure_present_title

  validate :chonological_start_and_end_times

  scope :starts_on, -> (date) { where(start_time: date.beginning_of_day..date.end_of_day) }
  scope :specific_time, -> { by_event_type(:specific_time) }
  scope :any_time, -> { by_event_type(:any_time) }
  scope :all_day, -> { by_event_type(:all_day) }

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
    event_type == :specific_time
  end

  def any_time?
    event_type == :any_time
  end

  def all_day?
    event_type == :all_day
  end

  def self.by_event_type(event_type)
    where(event_type_id: EventType[event_type].id)
  end

  private

  def ensure_present_title
    self.title = 'Untitled' if title.blank?
  end

  def chonological_start_and_end_times
    if specific_time?
      errors.add(:base, "End time must be later than start time") if end_time <= start_time
    else
      errors.add(:base, "End date can't be earlier than start date") if end_time < start_time
    end
  end
end
