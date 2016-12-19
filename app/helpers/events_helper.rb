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

  def weekdays_of_date(date)
    (date.beginning_of_week..date.end_of_week).to_a
  end

  def abbr_day_name(date)
    date.strftime('%A').first(3).upcase
  end

  def month_and_year_of_date(date)
    "#{Date::MONTHNAMES[date.month]} #{date.year}"
  end
end
