class AppAuthorizationRequest < ApplicationRecord
  belongs_to :user
  belongs_to :tenant
  has_many :app_authorization_responses

  def responses
    app_authorization_responses
  end

  def last_response
    responses.order(:created_at).last
  end

  def last_response_type?(response_type)
    last_response.response_type == response_type
  end

  def open?
    last_response.nil? || last_response_type?(:revoke)
  end

  def self.current_requests(user_id)
    where(user_id: user_id).
      includes(:tenant, :app_authorization_responses)
  end

  def self.can_create?(tenant, user_id)
    !tenant.app_authorization_requests.where(user_id: user_id).any?
  end
end
