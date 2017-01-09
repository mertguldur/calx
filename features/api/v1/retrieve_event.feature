Feature: Retrieve event

  Scenario: Retrieve an existing event
    Given my tenant "My app" has access to user with API ID "123"
    And time zone is set to user's time zone
    And I have an event with the following attributes
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-01 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-01 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    When I send a GET request to "api/v1/events/#{@event.id}"
    Then the response status should be "200"
    And the JSON response should be:
      """
      {
        "id": @event.id,
        "title": "#{@event.title}",
        "event_type": "#{@event.event_type}",
        "start_time": "#{@event.start_time.as_json}",
        "end_time": "#{@event.end_time.as_json}",
        "notes": "#{@event.notes}"
      }
      """
  Scenario: Event doesn't exist
    Given my tenant "My app" has access to user with API ID "123"
    When I send a GET request to "api/v1/events/1"
    Then the response status should be "404"

  Scenario: Attempt to retrieve another user's event
    Given my tenant "My app" has access to user with API ID "123"
    When another user has an event
    And I send a GET request to "api/v1/events/#{@other_users_event.id}"
    Then the response status should be "401"

  Scenario: Tenant doesn't have access to user
    Given I have a tenant called "My app" with API access
    And I have a user with API ID "123"
    Given I have an event with the following attributes
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-01 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-01 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    When I send a GET request to "api/v1/events/#{@event.id}"
    Then the response status should be "401"
