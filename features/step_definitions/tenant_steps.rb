Given(/^I have a tenant called "(.*?)" with API access$/) do |tenant|
  @tenant = Tenant.create!(access_id: tenant)
  allow(Tenant).to receive(:find_by_access_id) { @tenant }
  allow(ApiAuth).to receive(:authentic?) { true }
end

Given(/^my tenant "(.*?)" has access to user with API ID "(.*?)"$/) do |tenant, api_id|
  step("I have a tenant called \"#{tenant}\" with API access")
  step("I have a user with API ID \"#{api_id}\"")

  auth_request = AppAuthorizationRequest.create!(tenant: @tenant, user: @user)
  AppAuthorizationResponse.create! \
    app_authorization_request: auth_request,
    app_authorization_response_type: AppAuthorizationResponseType[:grant]
end
