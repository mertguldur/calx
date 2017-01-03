class AddAppAuthorizationResponseTypes < ActiveRecord::Migration[5.0]
  def change
    [:grant, :revoke, :remove, :block].each do |type|
      AppAuthorizationResponseType.find_or_create_by!(app_authorization_response_type: type)
    end
  end
end
