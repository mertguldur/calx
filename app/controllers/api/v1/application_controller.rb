module Api
  module V1
    class ApplicationController < ActionController::Base
      before_action :authenticate_request!

      protected

      def authenticate_request!
        @tenant = Tenant.find_by_access_id(ApiAuth.access_id(request))
        head(:unauthorized) unless @tenant && ApiAuth.authentic?(request, @tenant.secret_key)
      end
    end
  end
end
