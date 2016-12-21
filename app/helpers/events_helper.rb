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
