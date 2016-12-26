Feature: Sign in

  Background:
    Given the following user exists
      | email     | mock@mockmail.com |
      | password  | 12341234 |
    And I am on the landing page

  Scenario: Successful sign in
    When I fill in the "session" form with the following
      | email    | mock@mockmail.com |
      | password | 12341234 |
    And I click button "Sign in"
    Then I should be on the calendar page

  Scenario: Empty email
    When I fill in the "session" form with the following
      | email    | |
      | password | 12341234 |
    And I click button "Sign in"
    Then I should be on the sign in page

  Scenario: Wrong email
    When I fill in the "session" form with the following
      | email    | mock2@mockmail.com |
      | password | 12341234 |
    And I click button "Sign in"
    Then I should be on the sign in page

  Scenario: Empty password
    When I fill in the "session" form with the following
      | email    | mock@mockmail.com |
      | password | |
    And I click button "Sign in"
    Then I should be on the sign in page

  Scenario: Wrong password
    When I fill in the "session" form with the following
      | email    | mock@mockmail.com |
      | password | 123412345 |
    And I click button "Sign in"
    Then I should be on the sign in page
