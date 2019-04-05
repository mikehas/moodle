@core @core_grades
Feature: We can format grades as letters.
  In order to ensure letter grades are accurate when floats are used
  As a teacher
  I need to add activities to the gradebook with values that cause float errors
  I need to ensure that the course grade is an A- and not a B+ when a student has 297.9/331 points

  @javascript
  Scenario: I edit the letter boundaries of a course and grade a student.
    Given the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1 | 0 |
    And the following "users" exist:
      | username | firstname | lastname | email | idnumber | alternatename |
      | teacher1 | Teacher | 1 | teacher1@example.com | t1 | Terry         |
      | student1 | Student | 1 | student1@example.com | s1 | Sally         |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
      | student1 | C1 | student |
    And the following "activities" exist:
      | activity | course | idnumber | name | intro | grade |
      | assign | C1 | a1 | Test assignment one | Submit something! | 100 |
      | assign | C1 | a2 | Test assignment two | Submit something! | 231 |
    And I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I navigate to "View > Grader report" in the course gradebook
    And I turn editing mode on
    And I give the grade "100.00" to the user "Student 1" for the grade item "Test assignment one"
    And I give the grade "197.90" to the user "Student 1" for the grade item "Test assignment two"
    And I press "Save changes"
    And I am on "Course 1" course homepage
    And I navigate to "Setup > Course grade settings" in the course gradebook
    And I set the following fields to these values:
      | Grade display type | Letter |
    And I press "Save changes"
    And I turn editing mode off
    And I navigate to "View > Grader report" in the course gradebook
    Then the following should exist in the "user-grades" table:
      | -1-       | -6- |
      | Student 1 | A-  |
