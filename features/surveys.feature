Feature: Managing surveys 
  In order to manage surveys
  As an admin
  I want to authenticate to administrators panel and create or modify surveys

  Scenario: Open empty survey list
    Given no surveys
    When I log in
      And I go to the admin site
    Then I should see "No surveys added" within "p"