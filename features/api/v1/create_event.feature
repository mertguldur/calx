Feature: Create event

  Scenario: Successful event creation
    Given my tenant "My app" has access to user with API ID "123"
    When I send a POST request to "api/v1/users/123/events" with the following:
      | title      | Lunch |
      | event_type | specific_time |
      | start_time | 2017-01-01T12:30:00.000 |
      | end_time   | 2017-01-01T13:30:00.000 |
      | notes      | Business meeting |
    And I know my event
    Then the response status should be "201"
    And the JSON response should be:
      """
      {
        "id": @event.id,
        "title": "Lunch",
        "event_type": "specific_time",
        "start_time": "2017-01-01T12:30:00.000-06:00",
        "end_time": "2017-01-01T13:30:00.000-06:00",
        "notes": "Business meeting"
      }
      """

  Scenario: Invalid event value
    Given my tenant "My app" has access to user with API ID "123"
    When I send a POST request to "api/v1/users/123/events" with the following:
      | title      | Lunch |
      | event_type | specific_time |
      | start_time | 2017-01-01T14:30:00.000 |
      | end_time   | 2017-01-01T13:30:00.000 |
      | notes      | Business meeting |
    Then the response status should be "422"
    And the JSON response should be:
      """
      { "errors": [{"id"=>"end_time", "title"=>"must be later than start time"}] }
      """

  Scenario: User doesn't exist
    Given my tenant "My app" has access to user with API ID "123"
    When I send a POST request to "api/v1/users/567/events" with the following:
      | title      | Lunch |
      | event_type | specific_time |
      | start_time | 2017-01-01T14:30:00.000 |
      | end_time   | 2017-01-01T13:30:00.000 |
      | notes      | Business meeting |
    Then the response status should be "404"

  Scenario: Tenant doesn't have access to user
    Given I have a tenant called "My app" with API access
    And I have a user with API ID "123"
    When I send a POST request to "api/v1/users/123/events" with the following:
      | title      | Lunch |
      | event_type | specific_time |
      | start_time | 2017-01-01T14:30:00.000 |
      | end_time   | 2017-01-01T13:30:00.000 |
      | notes      | Business meeting |
    Then the response status should be "401"
