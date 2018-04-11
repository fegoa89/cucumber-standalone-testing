Feature: Search Questions
  In order to find an answer to my technical question
  As a user of Stack Overflow
  I want to search and find answers

  Scenario: Search for bdd testing
    Given I am on the home page
    And I search for "bdd testing"
    Then I should see "results found containing bdd testing"
