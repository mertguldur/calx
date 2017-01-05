class EventPresenter
  def initialize(event)
    @event = event
  end

  def as_json(options = {})
    {
      id: @event.id,
      title: @event.title,
      event_type: @event.event_type,
      start_time: @event.start_time,
      end_time: @event.end_time,
      notes: @event.notes
    }
  end
end
