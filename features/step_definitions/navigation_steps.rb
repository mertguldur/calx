Given(/^I am on the landing page$/) do
  visit root_path
end

Given(/^I am on the account update page$/) do
  click_link('Settings')
end

When(/^I click button "(.*?)"$/) do |text|
  click_button(text)
end

Given(/^I click link "(.*?)"$/) do |text|
  click_link(text)
end

Then(/^I should be on the calendar page$/) do
  expect(page).to have_css('.calendar-date-navigators')
end

Then(/^I should be on the sign in page$/) do
  expect(page).to have_css('.sign-in-form')
end

Then(/^I should be on the sign up page$/) do
  expect(page).to have_css('.sign-up-form')
end
