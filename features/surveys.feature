Feature: Managing surveys 
  In order to manage surveys
  As an admin
  I want to authenticate to administrators panel and create or modify surveys

  Scenario: Open empty survey list
    Given no surveys
    When I log in
      And I go to the admin site
    Then I should see "No surveys added" within "p"
    
  Scenario: Open survey list with 2 surveys titled Music and Movies
    Given the following surveys exist
      | title  | description      | author |
      | Music  | All about music  | admin  |
      | Movies | All about movies | admin  |
    When I log in
      And I go to the admin site
    Then I should see "Music" within "td"
    And I should see "Movies" within "td"
    And I should see "All about music" within "td"
    And I should see "All about movies" within "td"
    And I should see "admin" within "td"
    And I should see "0" in "td#1.number_of_results"
    And I should see "0" in "td#2.number_of_results"
    And I should see "N" in "td.published"
    
  Scenario: Successfully create new unpublished survey without questions
    Given no surveys
    And I am on the admin site
    When I follow "New Survey"
    And I fill in "Title" with "Music"
    And I fill in "Description" with "Music"
    And I fill in "Author" with "admin"
    And I leave checkbox "Published ?" unchecked
    And I press "Create"
    Then I should be on the admin/surveys page
    And I should see notice "New survey created !"
    And I should see "N" in "td.published"
    
  Scenario: Fail to create new survey without title, description and author specified
    Given no surveys
    And I am on the admin site
    When I follow "New Survey"
    And I press "Create"
    Then I should be on the page titled "New Survey"
    Then I should see errors "Title can't be blank", "Author can't be blank", "Description can't be blank"
  
  @javascript
  Scenario: Successfully create new unpublished survey with questions
    Given no surveys
    And I am on the admin site
    When I follow "New Survey"
    And I fill in "Title" with "Music"
    And I fill in "Description" with "Music"
    And I fill in "Author" with "admin"
    And I fill in "Question #1" with "What is your favorite music genre?"
    And I select "option" from "Answer is"
    # And I add 1st question "What is your favorite music genre?" with answer type "option"
    #TODO: Need to find out how to dry it up
    And I fill in "Answer #1.1" with "Folk"
    And I add 2nd answer "Rock" to 1st question
    And I add 3rd answer "Classical" to 1st question
    And I add 4th answer "Pop" to 1st question
    And I add 5th answer "Soul" to 1st question
    And I add 6th answer "Jazz" to 1st question
    And I add 7th answer "Blues" to 1st question
    And I add 8th answer "Metal" to 1st question
    And I add 9th answer "Hip-Hop" to 1st question
    And I add 10th answer "Rap" to 1st question
    And I add 11th answer "Other" to 1st question
    And I add 1st question "What is your favorite band of this genre?" with answer type "text"
    And I add 1st question "How many years have you been listening to this music?" with answer type "number"
    And I leave checkbox "Published ?" unchecked
    And I press "Create"
    Then I should be on the admin/surveys page
    And I should see notice "New survey created !"
    And I should see "N" in "td.published"