Feature: Search Questions
  In order to find an answer to a question
  As a DuckDuckGo user
  I want to search and find answers

  Scenario: Search for bdd testing
    Given I am on the home page
    And I search for "bdd testing"
    Then I will hopefully see "bdd" in my search results
