class AppAuthorizationResponsesController < ApplicationController
  def create
    auth_request = AppAuthorizationRequest.find(params[:app_authorization_request_id])
    auth_request.responses << AppAuthorizationResponse.new(
      app_authorization_response_type: params[:app_authorization_response_type]
    )
    auth_request.save!
    redirect_to app_authorization_requests_path
  end
end
