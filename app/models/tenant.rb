class Tenant < ApplicationRecord
  has_many :app_authorization_requests

  before_create { self.secret_key = ApiAuth.generate_secret_key }

  validates :access_id, presence: true
end
