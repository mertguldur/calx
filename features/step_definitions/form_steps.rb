When(/^I fill in the "(.*?)" form with the following$/) do |form_type, table|
  table.rows_hash.each do |field, value|
    fill_in "#{form_type}_#{field}", with: form_value(field, value)
  end
end
