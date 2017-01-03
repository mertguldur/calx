class EventsController < ApplicationController
  before_action :authenticate_user!

  around_action :set_time_zone, if: :current_user

  def index
    now = Time.current
    @today = now.to_date
    @date = params[:date]&.to_date || @today
    @events = Event.list_for_date(@date, current_user)
    @upcoming_event = Event.upcoming(@events, now)
  end

  def new
    @now = Time.current
    date = params[:date] || now.to_date
    @start_date, @end_date = date, date
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path(date: @event.start_date)
    else
      render 'new'
    end
  end

  def show
    @event = Event.find_by_id(params[:id])
    redirect_to root_path if @event.nil? || @event.user_id != current_user.id
  end

  def update
    @event = Event.find(params[:id])
    redirect_to root_path if @event.user_id != current_user.id
    @event.attributes = event_params
    flash.now[:success] = 'Changes saved successfully' if @event.save
    render 'show'
  end

  def delete
    @event = Event.find(params[:id])
    redirect_to root_path if @event.user_id != current_user.id
    @event.delete
    redirect_to events_path(date: @event.start_date)
  end

  private

  def event_params
    permitted = params.permit \
      :title, :event_type, :start_date, :start_time, :end_date, :end_time, :notes

    if permitted[:event_type].in?(['any_time', 'all_day'])
      permitted[:start_time], permitted[:end_time] = nil, nil
    end
    permitted[:start_time] = combine_date_and_time(permitted[:start_date], permitted[:start_time])
    permitted.delete(:start_date)

    permitted[:end_time] = combine_date_and_time(permitted[:end_date], permitted[:end_time])
    permitted.delete(:end_date)

    permitted[:event_type_id] = EventType[permitted[:event_type]].id
    permitted.delete(:event_type)

    permitted[:user_id] = current_user.id
    permitted
  end

  def combine_date_and_time(date, time = nil)
    date = Date.strptime(date, "%m/%d/%Y").to_s
    Time.zone.parse("#{date} #{time}")
  end
end
