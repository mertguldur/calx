module AppAuthorizationsHelper
  def auth_response_link(link_name, response_type, auth_request)
    link_to link_name,
            {
              controller: 'app_authorization_responses',
              action: 'create',
              app_authorization_request_id: auth_request.id,
              app_authorization_response_type: response_type
            },
            method: 'post'
  end
end
