class AppAuthorizationRequestsController < ApplicationController
  def index
    @app_authorization_requests = AppAuthorizationRequest.current_requests(current_user.id)
  end
end
