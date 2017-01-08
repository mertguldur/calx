Feature: App authorizations

  Scenario: Successful app authorization request submission
    Given I have a tenant called "My app" with API access
    And I have a user with API ID "123"
    When I send a POST request to "api/v1/app_authorization_requests" with the following:
      | user_id | 123 |
    Then the response status should be "201"
    And the JSON response should be:
    """
    { "tenant_id": @tenant.id, "user_id": "#{@user.api_id}" }
    """

  Scenario: User doesn't exist
    Given I have a tenant called "My app" with API access
    And I have a user with API ID "123"
    When I send a POST request to "api/v1/app_authorization_requests" with the following:
      | user_id | 567 |
    Then the response status should be "422"
    And the JSON response should be:
    """
    { "errors": [{ "title": "User doesn't exist" }] }
    """

  Scenario: Tenant already submitted a request
    Given I have a tenant called "My app" with API access
    And I have a user with API ID "123"
    When I send a POST request to "api/v1/app_authorization_requests" with the following:
      | user_id | 123 |
    When I send a POST request to "api/v1/app_authorization_requests" with the following:
      | user_id | 123 |
    Then the response status should be "422"
    And the JSON response should be:
    """
    { "errors": [{ "title": "Client can't be authorized for this user" }] }
    """
