module EventsHelper
  def possible_event_times
    date = Date.new
    time = date.beginning_of_day
    end_time = date.end_of_day
    times = []
    interval = 30.minutes
    while time < end_time do
      times << format_event_time(time)
      time += interval
    end
    times
  end

  def format_event_time(time)
    time.strftime("%I:%M%P")
  end
end
