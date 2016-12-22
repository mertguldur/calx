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

  def default_event_start_time(event)
    return format_event_time(event.start_time) if event.start_time
    possible_event_times.first
  end

  def default_event_end_time(event)
    return format_event_time(event.end_time) if event.end_time
    possible_event_times.second
  end

  def format_event_time(time)
    time.strftime("%I:%M%P")
  end

  def event_form_date(event_date, date = nil)
    (event_date || date.to_date).strftime("%m/%d/%Y")
  end

  def weekdays_of_date(date)
    (date.beginning_of_week..date.end_of_week).to_a
  end

  def abbr_day_name(date)
    date.strftime('%A').first(3).upcase
  end

  def month_and_year_of_date(date)
    first_day_month = month_of_date(date.beginning_of_week)
    first_day_year = date.beginning_of_week.year
    last_day_month = month_of_date(date.end_of_week)
    last_day_year = date.end_of_week.year

    if first_day_year == last_day_year
      if first_day_month == last_day_month
        "#{first_day_month} #{first_day_year}"
      else
        "#{first_day_month} / #{last_day_month} #{first_day_year}"
      end
    else
      "#{first_day_month} #{first_day_year} / #{last_day_month} #{last_day_year}"
    end
  end

  def month_of_date(date)
    Date::MONTHNAMES[date.month]
  end
end
