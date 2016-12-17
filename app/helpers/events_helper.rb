module EventsHelper
  def event_times
    date = Date.new
    time = date.beginning_of_day
    end_time = date.end_of_day
    times = []
    interval = 30.minutes
    while time < end_time do
      times << event_time(time)
      time += interval
    end
    times
  end

  def event_time(time)
    time.strftime("%I:%M%P")
  end
end
