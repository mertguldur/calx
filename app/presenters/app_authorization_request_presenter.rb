class AppAuthorizationRequestPresenter
  def initialize(app_authorization_request)
    @app_authorization_request = app_authorization_request
  end

  def as_json(_options = {})
    {
      tenant_id: @app_authorization_request.tenant_id,
      user_id: @app_authorization_request.user.api_id
    }
  end
end
