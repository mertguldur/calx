Given(/^I am on the landing page$/) do
  visit root_path
end

Given(/^I am on the account update page$/) do
  click_link('Settings')
end

Given(/^I am on the new event page$/) do
  visit new_event_path
end

Given(/^I click link "(.*?)"$/) do |text|
  click_link(text)
end

Given(/^I am on the calendar page on date "(.*?)"$/) do |date|
  visit events_path(date: date)
end

When(/^I go to a nonexistent event page$/) do
  visit show_event_path(id: 0)
end

When(/^I go to another user's event page$/) do
  visit show_event_path(@other_users_event)
end

When(/^I click button "(.*?)"$/) do |text|
  click_button(text)
end

Then(/^I should be on the calendar page$/) do
  expect(page).to have_css('.calendar-date-navigators')
end

Then(/^I should be on the calendar page on date "(.*?)"$/) do |date|
  expect(page).to have_css('.calendar-date-navigators')
  page_date = Date.strptime(find('#calendar-datepicker-input').value, '%m/%d/%Y')
  given_date = Date.parse(date)
  expect(page_date).to eq(given_date)
end

Then(/^I should be on the new event page$/) do
  expect(page).to have_css('.new-event-form')
end

Then(/^I should be on the event page$/) do
  expect(page).to have_css('.event-form')
end

Then(/^I should be on the sign in page$/) do
  expect(page).to have_css('.sign-in-form')
end

Then(/^I should be on the sign up page$/) do
  expect(page).to have_css('.sign-up-form')
end
