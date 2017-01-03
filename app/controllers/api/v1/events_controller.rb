module Api
  module V1
    class EventsController < Api::V1::ApplicationController
      before_action :authenticate_user_access!

      def index
        user = User.find_by_api_id(params[:user_id])
        date = params[:date]&.to_date || Date.current
        events = Event.list_for_date(date, user)
        render json: events
      end
    end
  end
end
