class EventsController < ApplicationController
  before_action :authenticate_user!

  around_action :set_time_zone, if: :current_user

  def index
    @today = Date.current
    @date = params[:date]&.to_date || @today
    @events = Event.where(user_id: current_user.id).starts_on(@date)
  end

  def new
    @start_date = params[:date] || Date.current
    @end_date = @start_date
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

  private

  def event_params
    permitted = params.permit(:title, :start_date, :start_time, :end_date, :end_time, :notes)

    permitted[:start_time] = Time.zone.parse("#{permitted[:start_date]}  #{permitted[:start_time]}")
    permitted.delete(:start_date)
    permitted[:end_time] = Time.zone.parse("#{permitted[:end_date]} #{permitted[:end_time]}")
    permitted.delete(:end_date)

    permitted[:user_id] = current_user.id
    permitted
  end
end
