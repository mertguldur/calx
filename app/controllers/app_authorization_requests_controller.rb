class AppAuthorizationRequestsController < ApplicationController
  def index
    @app_authorization_requests = AppAuthorizationRequest.requests_for(current_user.id)
  end
end
