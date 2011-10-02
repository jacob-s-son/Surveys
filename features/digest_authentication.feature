Feature: Authentication and authorization
  In order to manage surveys
  As an admin
  I want to authenticate to administrators panel

  Scenario: Log into administrator site
    Given no surveys
    When I log in with admin:test
      And I go to the admin site
    Then I should see "No surveys added" within "p"