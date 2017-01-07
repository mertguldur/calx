module EventHelper
  def parse_event_type(event_type)
    event_type.downcase.split(' ').join('_')
  end

  def parse_start_time(params)
    Time.zone.parse("#{params[:start_date]} #{params[:start_time]}")
  end

  def parse_end_time(params)
    Time.zone.parse("#{params[:end_date]} #{params[:end_time]}")
  end
end

World(EventHelper)
