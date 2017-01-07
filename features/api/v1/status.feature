Feature: Status

  Scenario: Retrieve app status
    When I send a GET request to "/api/v1/status"
    Then the response status should be "200"
    And the JSON response should be:
      """
      { "app": "CalX", "api_version": "V1", "status": "OK" }
      """
