-- Authors: Logan Jensen and Christopher Breniser
-- Date: May 18, 2020
-- Course: CS 340
-- Section: 401
-- Group: 36
-- Project Title: Library Loan-System Database
--------------------------------------------------------

--
-- Manipuation for Students
-- Manage Students page requires SELECT, INSERT, DELETE, UPDATE
--

-- Query to display studentID, first_name, last_name, and email for all students
SELECT * FROM `Students`;


-- Query to insert new student into Students table
INSERT INTO `Students` (`first_name`, `last_name`, `email`)
VALUES (:first_name_input, :last_name_input, :email_input);

-- Query to delete a student based on studentID
DELETE FROM `Students` WHERE studentID = :studentID;

-- Query to update a student's first_name, last_name, or email
UPDATE `Students`
SET first_name = :first_name_input, last_name = :last_name_input, email = :email_input
WHERE studentID = :studentID_input;

--
-- Manipuation for Books_On_Loan
-- Books on Loan page requires SELECT, INSERT, DELETE, UPDATE
--

-- Query to display all info of a book on loan: loanID, studentID, bookID, date loaned, date due, date returned, late fee
SELECT * FROM `Books_On_Loan`;

-- Query to create a new loaned book
INSERT INTO `Books_On_Loan` (`bookID`, `studentID`, `date_checkout`, `date_due`, `date_returned`, `late_fee`)
VALUES (:bookID, :studentID, :date_checkout, :date_due, :date_returned, :late_fee);

-- Query to delete a book on loan
DELETE FROM `Books_On_Loan` WHERE loanID = :loanID;

-- Query to update a book on loan
UPDATE `Books_On_Loan`
SET bookID = :bookID_input, studentID = :studentID_input, date_checkout = :date_checkout_input, date_due = :date_due_input, date_returned = :date_returned_input, late_fee = :late_fee_input
WHERE loanID = :loanID_input;