Feature: App authorizations

  Background:
    Given I have signed in
    Given I am on the apps page

  Scenario: Go to account information page
    When I click link "Account"
    Then I should be on the account information page

  Scenario: View API ID
    Then I should see my API ID

  Scenario: No apps requested access
    Then I should see the message "No apps requested access"

  Scenario: View app authorizations
    Given I have an authorization request from "My app"
    When I go to the apps page
    Then I should see an authorization request from "My app"

  Scenario: Grant access
    Given I have an authorization request from "My app"
    When I go to the apps page
    And I click link "Grant access"
    Then I should see that "My app" has been granted access

  Scenario: Revoke access
    Given I have an authorization request from "My app"
    When I go to the apps page
    And I click link "Grant access"
    And I click link "Revoke access"
    Then I should see that "My app"'s access has been revoked
