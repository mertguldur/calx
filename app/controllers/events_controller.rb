class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    date = params[:date] || Date.today
    @events = Event.where(start_time: date.beginning_of_day..date.end_of_day)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to show_event_path(@event)
    else
      render 'new'
    end
  end

  def show
    @event = Event.find_by_id(params[:id])
    redirect_to root_path unless @event
  end

  def update
    @event = Event.find(params[:id])
    @event.attributes = event_params
    flash.now[:success] = 'Changes saved successfully' if @event.save
    render 'show'
  end

  private

  def event_params
    permitted = params.permit(:title, :start_date, :start_time, :end_date, :end_time, :notes)
    permitted[:start_time] = combine_date_and_time(permitted[:start_date], permitted[:start_time])
    permitted.delete(:start_date)
    permitted[:end_time] = combine_date_and_time(permitted[:end_date], permitted[:end_time])
    permitted.delete(:end_date)
    permitted
  end

  def combine_date_and_time(date, time)
    date = Date.parse(date)
    time = Time.parse(time)
    Time.new(date.year, date.month, date.day, time.hour, time.min)
  end
end
