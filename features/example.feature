@example @p
Feature: Example Feature
  When I want to learn how to make test cases
  As a user of the test automation tool
  I want to run and adjust the tests below

  Background: Steps before every scenario
    Given I navigate to url "http://www.spritecloud.com"

  @example01
  Scenario: example01 - Navigation website
    When I click on link "Home"
    Then I should see text "Website Testing Services, Consultancy and Solutions."
    And I use value "test@testing.com" for field "email"
    And I click on button "Contact me"
    And I click on link "Services"
    Then I should see text "spriteCloud Quality Assurance Services"

  @example02
  Scenario Outline: example02 - Navigation mainmenu from table
    When I click on link "<link_name>"
    And I should see text "<text>"
  Scenarios: Values
    | link_name    | text                                                 |
    | Home         | Website Testing Services, Consultancy and Solutions. |
    | Services     | spriteCloud Quality Assurance Services               |

  @example03
  Scenario: example03 - See a 404 Error
    Given I navigate to url "http://spritecloud.com"
    Then I should see text "This is an example of a failed scenario"