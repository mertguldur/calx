module Api
  module V1
    class EventsController < Api::V1::ApplicationController
      before_action :authenticate_user_access!
      around_action :set_time_zone

      def index
        date = params[:date]&.to_date || Date.current
        events = Event.list_for_date(date, @user)
        render json: events.map { |event| EventPresenter.new(event) }
      end

      def show
        render json: EventPresenter.new(@event)
      end

      def create
        event = Event.new(create_event_params)
        if event.save
          render json: EventPresenter.new(event), status: :created
        else
          render json: { errors: event.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @event.update(update_event_params)
          render json: EventPresenter.new(@event)
        else
          render json: { errors: @event.errors }, status: :unprocessable_entity
        end
      end

      def delete
        @event.delete
        head(:ok)
      end

      private

      def authenticate_user_access!
        if params[:user_id]
          @user = User.find_by_api_id(params[:user_id])
        elsif params[:id]
          @event = Event.find_by_id(params[:id])
          @user = @event&.user
        end
        return head(:not_found) unless @user
        return head(:unauthorized) unless @tenant.has_access_to_user?(@user.api_id)
      end

      def set_time_zone
        Time.use_zone(@user.time_zone) { yield }
      end

      def create_event_params
        permitted = params.permit \
          :user_id, :title, :event_type, :start_time, :end_time, :notes

        parse_time_params(permitted)

        permitted[:user_id] = @user.id
        permitted
      end

      def update_event_params
        permitted = params.permit \
          :title, :event_type, :start_time, :end_time, :notes

        permitted.delete(:id)
        parse_time_params(permitted)
        permitted
      end

      def parse_time_params(permitted)
        non_specific_time = permitted[:event_type].in?(['any_time', 'all_day'])
        if permitted[:start_time]
          start_time = Time.zone.parse(permitted[:start_time])
          start_time = start_time.beginning_of_day if non_specific_time
          permitted[:start_time] = start_time
        end
        if permitted[:end_time]
          end_time = Time.zone.parse(permitted[:end_time])
          end_time = end_time.beginning_of_day if non_specific_time
          permitted[:end_time] = end_time
        end
        permitted
      end
    end
  end
end
