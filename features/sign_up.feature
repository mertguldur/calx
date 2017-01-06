Feature: Sign up

  Background:
    Given I am on the landing page
    And I click link "Don't have an account? Sign up"

  Scenario: Successful sign up
    When I fill in the sign up form with the following
      | email                 | mock@mockmail.com |
      | password              | 12341234 |
      | password_confirmation | 12341234 |
      | time_zone             | Central Time (US & Canada) |
    And I click button "Sign up"
    Then I should be on the calendar page

  Scenario: Invalid user value
    When I fill in the sign up form with the following
      | email                 | |
      | password              | 12341234 |
      | password_confirmation | 12341234 |
      | time_zone             | Central Time (US & Canada) |
    And I click button "Sign up"
    Then I should be on the sign up page
    And I should see the error "Email can't be blank"

  Scenario: Go back to sign in page
    When I click link "Sign in"
    Then I should be on the sign in page
