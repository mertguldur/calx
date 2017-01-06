Given(/^the following user exists$/) do |table|
  attributes = table.rows_hash
  FactoryGirl.create(:user, attributes)
end

Given(/^I have signed in$/) do
  sign_in
end
