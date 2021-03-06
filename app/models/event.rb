class Event < ApplicationRecord
  belongs_to :user
  lookup_for :event_type, symbolize: true

  before_save :ensure_present_title

  validates :start_time, :end_time, :event_type_id,
            presence: true

  validates_length_of :title, maximum: 500
  validates_length_of :notes, maximum: 10_000

  validate :chonological_start_and_end_times

  scope :starts_on, ->(date) { where(start_time: date.beginning_of_day..date.end_of_day) }
  scope :specific_time, -> { by_event_type(:specific_time) }
  scope :any_time, -> { by_event_type(:any_time) }
  scope :all_day, -> { by_event_type(:all_day) }

  def self.on_date(date, user)
    events = where(user_id: user.id).starts_on(date).order(:start_time)
    events.all_day + events.specific_time + events.any_time
  end

  def self.upcoming(events, now)
    events.select do |event|
      event.event_type?(:specific_time) &&
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

  def event_type?(event_type)
    self.event_type == event_type
  end

  def self.by_event_type(event_type)
    where(event_type_id: EventType[event_type].id)
  end

  private

  def ensure_present_title
    self.title = 'Untitled' if title.blank?
  end

  def chonological_start_and_end_times
    return unless start_time && end_time
    if event_type?(:specific_time)
      errors.add(:end_time, 'must be later than start time') if end_time <= start_time
    else
      errors.add(:end_time, "can't be earlier than start time") if end_time < start_time
    end
  end
end
