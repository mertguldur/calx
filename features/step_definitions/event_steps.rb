Then(/^I should see my event as "(.*?)"$/) do |text|
  date, title = text.split('-').map!(&:strip)
  expect(page).to have_content(date)
  expect(page).to have_content(title)
end
