module Api
  module V1
    class StatusController < Api::V1::ApplicationController
      skip_before_action :authenticate_request!

      def index
        render json: { app: 'CalX', api_version: 'V1', status: 'OK' }
      end
    end
  end
end
