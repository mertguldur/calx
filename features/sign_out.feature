Feature: Sign out

  Background:
    Given I have signed in

  Scenario: Sign out
    When I click link "Sign out"
    Then I should be on the sign in page
