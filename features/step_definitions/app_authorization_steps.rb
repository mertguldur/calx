Given(/^I have an authorization request from "(.*?)"$/) do |tenant|
  tenant = Tenant.create!(access_id: tenant)
  AppAuthorizationRequest.create!(tenant: tenant, user: @user)
end

Then(/^I should see an authorization request from "(.*?)"$/) do |tenant|
  expect(page).to have_content(tenant)
end

Then(/^I should see that "(.*?)" has been granted access$/) do |tenant|
  expect(page).to have_content(tenant)
  expect(page).to have_css('.icon-check')
  expect(page).to have_content('Revoke access')
end

Then(/^I should see that "(.*?)"'s access has been revoked$/) do |tenant|
  expect(page).to have_content(tenant)
  expect(page).to have_css('.icon-info')
  expect(page).to have_content('Grant access')
end

Then(/^I should see my API ID$/) do
  expect(page).to have_content("API ID: #{@user.api_id}")
end
