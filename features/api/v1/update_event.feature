Feature: Create event

  Scenario: Successful event update
    Given my tenant "My app" has access to user with API ID "123"
    And I have an event with the following attributes
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-01 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-01 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    When I send a PUT request to "api/v1/events/#{@event.id}" with the following:
      | event_type | any_time |
    Then the response status should be "200"
    And the JSON response should be:
      """
      {
        "id": @event.id,
        "title": "Lunch",
        "event_type": "any_time",
        "start_time": "2017-01-01T00:00:00.000-06:00",
        "end_time": "2017-01-01T00:00:00.000-06:00",
        "notes": "Business meeting"
      }
      """

  Scenario: Invalid event value
    Given my tenant "My app" has access to user with API ID "123"
    And I have an event with the following attributes
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-01 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-01 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    When I send a PUT request to "api/v1/events/#{@event.id}" with the following:
      | start_time | 2017-01-01T14:30:00.000 |
    Then the response status should be "422"
    And the JSON response should be:
      """
      { "errors": [{"id"=>"end_time", "title"=>"must be later than start time"}] }
      """

  Scenario: Event doesn't exist
    Given my tenant "My app" has access to user with API ID "123"
    When I send a PUT request to "api/v1/events/1" with the following:
      | event_type | any_time |
    Then the response status should be "404"

  Scenario: Tenant doesn't have access to user
    Given I have a tenant called "My app" with API access
    And I have a user with API ID "123"
    And I have an event with the following attributes
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-01 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-01 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    When I send a PUT request to "api/v1/events/#{@event.id}" with the following:
      | event_type | any_time |
    Then the response status should be "401"
