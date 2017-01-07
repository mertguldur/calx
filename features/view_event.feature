Feature: View event

  Background:
    Given I have signed in
    And today is "2017-01-01"
    And I have an event with the following attributes
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-01 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-01 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    And I am on the calendar page on date "2017-01-01"

  @javascript
  Scenario: View event
    When I click link "Lunch"
    Then I should be on the event page
    And I should see the event form with the following
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-01 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-01 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |

  Scenario: Attempt to view a nonexistent event
    When I go to a nonexistent event page
    Then I am on the calendar page on date "2017-01-01"

  Scenario: Attempt to view another user's event
    When another user has an event
    And I go to another user's event page
    Then I am on the calendar page on date "2017-01-01"
