Feature: Account update

  Background:
    Given I have signed in with the following user
      | email     | mock@mockmail.com |
      | password  | 12341234 |
      | time_zone | Central Time (US & Canada) |

    And I am on the account update page

  Scenario: View account information
    Then I should see the user form with the following
      | email                 | mock@mockmail.com |
      | password              | |
      | password_confirmation | |
      | time_zone             | Central Time (US & Canada) |
      | current_password      | |

  Scenario: Successful account update
    When I fill in the user form with the following
      | email            | changed@mockmail.com |
      | current_password | 12341234 |
    And I click button "Save changes"
    Then I should see the user form with the following
      | email | changed@mockmail.com |

  Scenario: Invalid current password
    When I fill in the user form with the following
      | email            | changed@mockmail.com |
      | current_password | invalidpass |
    And I click button "Save changes"
    Then I should see the error "Invalid current password"
    And I should see the user form with the following
      | email | mock@mockmail.com |

  Scenario: Invalid account value
    When I fill in the user form with the following
      | email            | |
      | current_password | 12341234 |
    And I click button "Save changes"
    Then I should see the error "Email can't be blank"
    And I should see the user form with the following
      | email | mock@mockmail.com |
