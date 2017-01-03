class AppAuthorizationResponse < ApplicationRecord
  lookup_for :app_authorization_response_type, symbolize: true

  def response_type
    app_authorization_response_type
  end
end
