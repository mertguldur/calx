Given(/^I have an event with the following attributes$/) do |table|
  hash = table.rows_hash
  @event = Event.create! \
    user: @user,
    title: hash['title'],
    event_type: hash['when'].split(' ').join('_'),
    start_time: Time.zone.parse("#{hash['start_date']} #{hash['start_time']}"),
    end_time: Time.zone.parse("#{hash['end_date']} #{hash['end_time']}"),
    notes: hash['notes']
end

When(/^another user has an event$/) do
  user = create_user(email: 'other@user.com')
  @other_users_event = FactoryGirl.create(:event, user: user)
end

Then(/^I should see my event as "(.*?)"$/) do |text|
  date, title = text.split('-').map!(&:strip)
  expect(page).to have_content(date)
  expect(page).to have_content(title)
end
