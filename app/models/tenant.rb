class Tenant < ApplicationRecord
  has_many :app_authorization_requests

  before_create { self.secret_key = ApiAuth.generate_secret_key }

  validates :access_id, presence: true

  def has_access_to_user?(user_api_id)
    AppAuthorizationRequest.find_by_sql(["
      SELECT id FROM
      (
        SELECT app_authorization_requests.id, app_authorization_response_types.app_authorization_response_type,
        rank() OVER (PARTITION BY app_authorization_requests.id ORDER BY app_authorization_responses.created_at DESC)
        FROM app_authorization_requests
        JOIN app_authorization_responses ON app_authorization_responses.app_authorization_request_id = app_authorization_requests.id
        JOIN app_authorization_response_types ON app_authorization_responses.app_authorization_response_type_id = app_authorization_response_types.id
        JOIN users ON users.id = app_authorization_requests.user_id
        WHERE users.api_id = ?
        AND app_authorization_requests.tenant_id = ?
      ) t
      WHERE rank = 1
      AND (app_authorization_response_type = ?)
   ", user_api_id, id, :grant]).any?
  end
end
