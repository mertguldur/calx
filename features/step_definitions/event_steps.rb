Given(/^I have an event with the following attributes$/) do |table|
  hash = table.rows_hash.symbolize_keys!
  @event = Event.create! \
    user: @user,
    title: hash[:title],
    event_type: parse_event_type(hash[:when]),
    start_time: parse_start_time(hash),
    end_time: parse_end_time(hash),
    notes: hash[:notes]
end

Given(/^I have the following events on "(.*?)"$/) do |date, table|
  table.rows_hash.each do |time, title|
    event_type = time.downcase.in?(['all day', 'any time']) ? parse_event_type(time) : 'specific_time'
    time = event_type == 'specific_time' ? time : '12:00am'
    start_time = parse_start_time(start_date: date, start_time: time)
    end_time =  start_time + 30.minutes
    Event.create! \
      user: @user,
      title: title,
      event_type: event_type,
      start_time: start_time,
      end_time: end_time
  end
end

When(/^another user has an event$/) do
  user = create_user(email: 'other@user.com')
  @other_users_event = FactoryGirl.create(:event, user: user)
end

Then(/^I should see the following events on the calendar$/) do |table|
  table.rows_hash.each do |time, title|
    expect(page).to have_content(time)
    expect(page).to have_content(title)
  end
end

Then(/^I should see my event as "(.*?)"$/) do |text|
  date, title = text.split('-').map!(&:strip)
  expect(page).to have_content(date)
  expect(page).to have_content(title)
end
