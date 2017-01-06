class Tenant < ApplicationRecord
  has_many :app_authorization_requests

  before_create { self.secret_key = ApiAuth.generate_secret_key }

  validates :access_id, presence: true

  def access_to_user?(user_api_id)
    AppAuthorizationRequest.find_by_sql(["
      SELECT id FROM
      (
        SELECT req.id, rep_t.app_authorization_response_type,
        rank() OVER (PARTITION BY req.id ORDER BY rep.created_at DESC)
        FROM app_authorization_requests req
        JOIN app_authorization_responses rep
          ON rep.app_authorization_request_id = req.id
        JOIN app_authorization_response_types rep_t
          ON rep.app_authorization_response_type_id = rep_t.id
        JOIN users u ON u.id = req.user_id
        WHERE u.api_id = ? AND req.tenant_id = ?
      ) t
      WHERE rank = 1 AND (app_authorization_response_type = ?)
   ", user_api_id, id, :grant]).any?
  end
end
