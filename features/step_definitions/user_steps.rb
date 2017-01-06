Given(/^the following user exists$/) do |table|
  attributes = table.rows_hash
  @user = FactoryGirl.create(:user, attributes)
end

Given(/^I have signed in$/) do
  @user = sign_in
end

Given(/^I have signed in with the following user$/) do |table|
  attributes = table.rows_hash
  @user = sign_in(attributes)
end
