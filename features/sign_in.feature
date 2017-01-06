Feature: Sign in

  Background:
    Given the following user exists
      | email     | mock@mockmail.com |
      | password  | 12341234 |
    And I am on the landing page

  Scenario: Successful sign in
    When I fill in the sign in form with the following
      | email    | mock@mockmail.com |
      | password | 12341234 |
    And I click button "Sign in"
    Then I should be on the calendar page

  Scenario: Invalid session value
    When I fill in the sign in form with the following
      | email    | |
      | password | 12341234 |
    And I click button "Sign in"
    Then I should be on the sign in page
    And I should see the error "Invalid email/password combination"
