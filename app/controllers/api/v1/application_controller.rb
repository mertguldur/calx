module Api
  module V1
    class ApplicationController < ActionController::Base
      before_action :authenticate_request!

      protected

      def authenticate_request!
        @tenant = find_tenant
        head(:unauthorized) unless @tenant && ApiAuth.authentic?(request, @tenant.secret_key)
      end

      def find_tenant
        Tenant.find_by_access_id(ApiAuth.access_id(request))
      end
    end
  end
end
