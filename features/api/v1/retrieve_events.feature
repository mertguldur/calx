Feature: Retrieve events

  Scenario: Retrieve today's events by default
    Given my tenant "My app" has access to user with API ID "123"
    And today is "2017-01-01"
    And I have an event with the following attributes
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-01 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-01 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    When I send a GET request to "api/v1/users/123/events"
    Then the response status should be "200"
    And the JSON response should be:
      """
      [{
        "id": @event.id,
        "title": "Lunch",
        "event_type": "specific_time",
        "start_time": "2017-01-01T12:30:00.000-06:00",
        "end_time": "2017-01-01T13:30:00.000-06:00",
        "notes": "Business meeting"
      }]
      """

  Scenario: No events to retrieve today
    Given my tenant "My app" has access to user with API ID "123"
    And today is "2017-01-01"
    And I have an event with the following attributes
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-02 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-02 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    When I send a GET request to "api/v1/users/123/events"
    Then the response status should be "200"
    And the JSON response should be:
      """
      []
      """

  Scenario: Retrieve a date's events by passing a parameter
    Given my tenant "My app" has access to user with API ID "123"
    And today is "2017-01-01"
    And I have an event with the following attributes
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-02 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-02 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    When I send a GET request to "api/v1/users/123/events" with the following:
      | date | 2017-01-02 |
    Then the response status should be "200"
    And the JSON response should be:
      """
      [{
        "id": @event.id,
        "title": "Lunch",
        "event_type": "specific_time",
        "start_time": "2017-01-02T12:30:00.000-06:00",
        "end_time": "2017-01-02T13:30:00.000-06:00",
        "notes": "Business meeting"
      }]
      """

  Scenario: No events to retrieve on the passed date
    Given my tenant "My app" has access to user with API ID "123"
    And today is "2017-01-01"
    And I have an event with the following attributes
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-02 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-02 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    When I send a GET request to "api/v1/users/123/events"
      | date | 2017-01-01 |
    Then the response status should be "200"
    And the JSON response should be:
      """
      []
      """

  Scenario: User doesn't exist
    Given my tenant "My app" has access to user with API ID "123"
    When I send a GET request to "api/v1/users/567/events"
    Then the response status should be "404"

  Scenario: Tenant doesn't have access to user
    Given I have a tenant called "My app" with API access
    And I have a user with API ID "123"
    When I send a GET request to "api/v1/users/123/events"
    Then the response status should be "401"
