Given(/^the following user exists$/) do |table|
  attributes = table.rows_hash
  FactoryGirl.create(:user, attributes)
end
