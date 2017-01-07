Feature: Update event

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
    And I click link "Lunch"

  @javascript
  Scenario: Successful event update
    When I fill in the event form with the following
      | when | all day |
    And I click button "Save changes"
    Then I should see the message "Changes saved successfully"
    And I should see the event form with the following
      | title      | Lunch |
      | when       | all day |
      | start_date | 2017-01-01 |
      | start_time | 12:00am |
      | end_date   | 2017-01-01 |
      | end_time   | 12:00am |
      | notes      | Business meeting |

  @javascript
  Scenario: Invalid event value
    When I fill in the event form with the following
      | start_time | 02:00pm |
    And I click button "Save changes"
    Then I should see the error "End time must be later than start time"
