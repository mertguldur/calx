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

  Scenario: Delete event
    When I click link "Lunch"
    And I click button "Delete event"
    Then I am on the calendar page on date "2017-01-01"
    And I should not see an event with title "Lunch"
