Feature: Create event

  Background:
    Given I have signed in
    And today is "2016-12-15"
    And I am on the new event page

  @javascript
  Scenario: Successful event creation
    When I fill in the event form with the following
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-01 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-01 |
      | end_time   | 01:30pm |
      | notes      | Business meeting |
    And I click button "Create"
    Then I should be on the calendar page on date "2017-01-01"
    And I should see my event as "12:30pm - Lunch"

  @javascript
  Scenario: Invalid event value
    When I fill in the event form with the following
      | title      | Lunch |
      | when       | specific time |
      | start_date | 2017-01-01 |
      | start_time | 12:30pm |
      | end_date   | 2017-01-01 |
      | end_time   | 12:00pm |
      | notes      | Business meeting |
    And I click button "Create"
    Then I should be on the new event page
    And I should see the error "End time must be later than start time"

  Scenario: Going back to calendar
    When I click link "Back to calendar"
    Then I should be on the calendar page on date "2016-12-15"
