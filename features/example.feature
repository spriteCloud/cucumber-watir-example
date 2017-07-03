@example @p
Feature: Example Feature
  When I want to learn how to make test cases
  As a user of the test automation tool
  I want to run and adjust the tests below
  
  Acceptance Criteria:
  
  	- Some new acceptance criteria here

  Background: Steps before every scenario
    Given I navigate to url "http://www.spritecloud.com"

  @example01
  Scenario: example01 - Navigation website
    When I click on link "testing"
    Then I should see text "Test your software, not your reputation"
    And I click on link "industry"
    Then I should see text "Enterprise"
    Then I should see text "Brands"
    Then I should see text "Digital Agencies"
    Then I should see text "eCommerce"
    Then I should see text "Mobile"

  @example02
  Scenario Outline: example02 - Navigation mainmenu from table
    When I click on link "<link_name>"
    And I should see text "<text>"
  Scenarios: Values
    | link_name    | text                                    |
    | testing      | Test your software, not your reputation |
    | industry     | Services for digital agencies           |

  @example03
  Scenario: example03 - See a 404 Error
    Given I navigate to url "https://www.spritecloud.com"
    Then I should see text "This is an example of a failed scenario"

  @example04
  Scenario: example04 - Use datatables
    Given I navigate to url "https://www.spritecloud.com"
    Then the page should contain elements
      | title      | slogan                                  | footer                   |
      | spriteCloud| Test your software, not your reputation | Generaal Vetterstraat 72 |