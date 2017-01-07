When(/^I click next week$/) do
  click_link('calendar-week-right-arrow')
end

When(/^I click previous week$/) do
  click_link('calendar-week-left-arrow')
end

Then(/^I should see the month name as "(.*?)"$/) do |month|
  expect(page).to have_content(month)
end
