require 'jsonpath'

# rubocop:disable Metrics/LineLength
When(/^I send a (GET|PATCH|POST|PUT|DELETE) request (?:for|to) "([^"]*)"(?: with the following:)?$/) do |*args|
  # rubocop:enable Metrics/LineLength
  request_type = args.shift
  # rubocop:disable Lint/Eval
  path = eval("\"#{args.shift}\"")
  # rubocop:enable Lint/Eval
  input = args.shift
  options = { method: request_type.downcase.to_sym }
  unless input.nil?
    if input.class == Cucumber::MultilineArgument::DataTable
      options[:params] = input.rows_hash
    else
      options[:input] = StringIO.new(input)
    end
  end
  request(path, options)
end

Then(/^the response status should be "([^"]*)"$/) do |status|
  expect(last_response.status).to eq(status.to_i)
end

Then(/^the JSON response should be:$/) do |json|
  # rubocop:disable Lint/Eval
  json = eval(json).to_json
  # rubocop:enable Lint/Eval
  expected = JSON.parse(json)
  actual = JSON.parse(last_response.body)
  expect(actual).to eq(expected)
end
