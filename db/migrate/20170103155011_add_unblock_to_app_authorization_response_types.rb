class AddUnblockToAppAuthorizationResponseTypes < ActiveRecord::Migration[5.0]
  def change
    AppAuthorizationResponseType.find_or_create_by!(app_authorization_response_type: 'unblock')
    LookupBy.reload
  end
end
