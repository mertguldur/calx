Given(/^the following user exists$/) do |table|
  attributes = table.rows_hash
  @user = FactoryGirl.create(:user, attributes)
end

Given(/^I have a user with API ID "(.*?)"$/) do |api_id|
  @user = FactoryGirl.create(:user)
  @user.update(api_id: api_id)
end

Given(/^I have signed in$/) do
  @user = sign_in
end

Given(/^I have signed in with the following user$/) do |table|
  attributes = table.rows_hash
  @user = sign_in(attributes)
end
