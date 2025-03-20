#language: en
Feature: Person testing feature
# Person feature testing feature
# This file contains the different scenarios to test our person service.
# For this service we don’t need a database connection to store and find persons.
# The managed persons need to be stored in a list in the memory.

# First scenario to initialize the list of persons
Scenario: Initializing a given list of persons
  Given I have a static method which initializes a list of persons
  When I connect I can see the size of the initialized list of persons
  Then The list size is equal to 3

# Create a new Person with random entries
Scenario: Creating a new Person
  Given The list of persons contains 3 persons already stored
  When I create a new person with random entries
  Then I get the ID of the new person and the list contains more than 3 persons.

# Person Bulk creation
Scenario Outline: Bulk creation
  Given The list of persons contains 3 persons already stored
  When I create a new Person with <FirstName> <LastName> and <Age>
  Then I get the ID of the new Person and the list contains more than 3 persons

Examples:
  | FirstName | LastName | Age |
  | luke      | jacobs   | 30  |
  | Mark      | Dupon    | 41  |
  | Mike      | Jobs     | 20  |

# Updating an existing person
Scenario Outline: Update a person by ID
  Given The list of persons contains 3 persons already stored
  When I update a Person data with <ID> and <FirstName> <LastName> and <Age>
  Then I get the person updated

Examples:
  | ID | FirstName | LastName | Age |
  | 1  | Ali       | BOULAIT  | 31  |
  | 2  | Mark2     | Dupon2   | 44  |
  | 3  | Mike      | Jobs2    | 21  |

# Delete an existing person
Scenario: Delete a given person
  Given The list of persons contains 3 persons already stored
  When I delete a person with ID "1"
  Then The given person is deleted and the list size is equal to "2"
