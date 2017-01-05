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

Then(/^I should see the error "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
