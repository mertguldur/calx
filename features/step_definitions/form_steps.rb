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

When(/^I fill in the event form with the following$/) do |table|
  hash = table.rows_hash

  fill_in 'title', with: hash['title'] if hash['title'].present?
  find(event_type_radio_id(hash['when']), visible: false).trigger('click') if hash['when'].present?

  if hash['start_date'].present?
    execute_script("$('#start_date').val('#{datepicker_value(hash['start_date'])}')")
  end

  if hash['start_time'].present?
    find('#event-start-time-dropdown').find("option[value='#{hash['start_time']}']").select_option
  end

  if hash['end_date'].present?
    execute_script("$('#end_date').val('#{datepicker_value(hash['end_date'])}')")
  end

  if hash['end_time'].present?
    find('#event-end-time-dropdown').find("option[value='#{hash['end_time']}']").select_option
  end

  fill_in 'notes', with: hash['notes'] if hash['notes'].present?
end

Then(/^I should see the user form with the following$/) do |table|
  table.rows_hash.each do |field, value|
    page_value = find_by_id(field).value
    value = nil if value.blank?

    expect(page_value).to eq(value)
  end
end

Then(/^I should see the event form with the following$/) do |table|
  hash = table.rows_hash

  expect(find('#title').value).to eq(hash['title'])
  expect(find(event_type_radio_id(hash['when']), visible: false)).to be_checked

  expect(find('#start_date').value).to eq(datepicker_value(hash['start_date']))
  expect(find('#event-start-time-dropdown').value).to eq(hash['start_time'])

  expect(find('#end_date').value).to eq(datepicker_value(hash['end_date']))
  expect(find('#event-end-time-dropdown').value).to eq(hash['end_time'])

  expect(find('#notes').value).to eq(hash['notes'])
end

Then(/^I should see the error "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I should see the message "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
