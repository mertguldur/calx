class RemoveBlockingFromAppAuthResponses < ActiveRecord::Migration[5.0]
  def change
    block = AppAuthorizationResponseType[:block]
    unblock = AppAuthorizationResponseType[:unblock]
    AppAuthorizationResponse.where(app_authorization_response_type_id: block.id).destroy_all
    AppAuthorizationResponse.where(app_authorization_response_type_id: unblock.id).destroy_all
    block.destroy
    unblock.destroy
  end
end
