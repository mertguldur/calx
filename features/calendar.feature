Feature: Calendar

  Background:
    Given I have signed in
    And today is "2017-01-01"
    Given I am on the calendar page on date "2017-01-01"

  Scenario: Month names
    Then I should see the month name as "December 2016 / January 2017"
    When I click next week
    Then I should see the month name as "January 2017"
    When I click previous week
    When I click previous week
    Then I should see the month name as "December 2016"
    When I go to the calendar page on date "2016-11-28"
    Then I should see the month name as "November / December 2016"

  Scenario: Viewing a day's event
    Given I have an event with the following attributes
      | title      | Dinner |
      | when       | specific time |
      | start_date | 2017-01-03 |
      | start_time | 07:00pm |
      | end_date   | 2017-01-03 |
      | end_time   | 08:00pm |
    When I click next week
    And I click link "TUE"
    Then I should see my event as "7:00pm - Dinner"

  Scenario: Today button
    When I click link "SAT"
    And I click link "Today"
    Then I should be on the calendar page on date "2017-01-01"
    When I click next week
    And I click link "Today"
    Then I should be on the calendar page on date "2017-01-01"

  Scenario: Viewing different types of events
    Given I have the following events on "2017-01-02"
      | All day  | @Saint Tropez |
      | 01:00pm  | Yacht cruise |
      | Any time | Champagne |
    And I am on the calendar page on date "2017-01-02"
    Then I should see the following events on the calendar
      | All day  | @Saint Tropez |
      | 01:00pm  | Yacht cruise |
      | Any time | Champagne |
