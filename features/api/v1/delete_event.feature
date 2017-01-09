Feature: Delete event

  Scenario: Successful event deletion
    Given my tenant "My app" has access to user with API ID "123"
    And I have an event with the following attributes
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-01 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-01 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    When I send a DELETE request to "api/v1/events/#{@event.id}" with the following:
    Then the response status should be "200"

  Scenario: Event doesn't exist
    Given my tenant "My app" has access to user with API ID "123"
    When I send a DELETE request to "api/v1/events/1" with the following:
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
    When I send a DELETE request to "api/v1/events/#{@event.id}" with the following:
    Then the response status should be "401"
