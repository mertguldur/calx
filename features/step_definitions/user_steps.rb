Given(/^the following user exists$/) do |table|
  attributes = table.rows_hash
  FactoryGirl.create(:user, attributes)
end

Given(/^I have signed in$/) do
  sign_in
end

Given(/^I have signed in with the following user$/) do |table|
  attributes = table.rows_hash
  sign_in(attributes)
end
