When(/^I fill in the sign in form with the following$/) do |table|
  hash = table.rows_hash
  fill_in 'session_email', with: hash['email']
  fill_in 'session_password', with: hash['password']
end

When(/^I fill in the sign up form with the following$/) do |table|
  hash = table.rows_hash
  fill_in 'email', with: hash['email']
  fill_in 'password', with: hash['password']
  fill_in 'password_confirmation', with: hash['password_confirmation']
  find("option[value='#{hash['time_zone']}']").click
end

When(/^I fill in the user form with the following$/) do |table|
  hash = table.rows_hash
  fill_in 'email', with: hash['email']
  fill_in 'password', with: hash['password']
  fill_in 'password_confirmation', with: hash['password_confirmation']
  find("option[value='#{hash['time_zone']}']").click if hash['time_zone'].present?
  fill_in 'current_password', with: hash['current_password']
end

Then(/^I should see the user form with the following$/) do |table|
  table.rows_hash.each do |field, value|
    page_value = find_by_id(field).value
    value = nil if value.blank?

    expect(page_value).to eq(value)
  end
end

Then(/^I should see the error "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
