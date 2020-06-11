-- Authors: Logan Jensen and Chris Brensier
-- Date: May 18, 2020
-- Course: CS 340
-- Section: 401
-- Group: 36
-- Project Title: Library Loan-System Database

--
-- Manipuation for Books
-- Books need: Create, Read, Update, Delete
--

-- Read all entries of Book
SELECT * FROM Books
-- Create new book
INSERT INTO Books (title, year_published, authorID, genreID)
VALUES (:title_input, :year_published_input, :authorID_input, :genreID_input);
-- Read titles to fill loan a book drop down
SELECT bookID,title FROM Books
-- Read title of book with associated author and genre
SELECT bookID, title, year_published, Books.authorID, 
Authors.first_name, Authors.last_name, Genres.genre_name
FROM Books
INNER JOIN Authors ON Books.authorID = Authors.authorID
INNER JOIN Genres ON Books.genreID = Genres.genreID
ORDER BY Title, year_published
-- Update entry of book
UPDATE Books SET title = :title, year_published = :year_published WHERE bookID= :book_id_from_update_form
-- Delete book entry
DELETE FROM Books WHERE bookID = :book_id_from_delete_form

--
-- Manipuation for Genres
--

-- Read all Genres for main list page
SELECT * FROM Genres
-- Create new genre
INSERT INTO Genres (genre_name)
VALUES (:genre_name_input);
-- Read names for search drop down
SELECT genre_name AS genre FROM Genres
-- Update genre info (no planned implementation on the front end)
UPDATE Genres SET genre_name = :genre_name WHERE genreID = :genre_id_from_update_form
-- Delete genre entry
DELETE FROM Genres WHERE genreID = :genre_id_from_delete_form

--
-- Manipuation for Authors
--

-- Read all Authors for main list
SELECT * FROM Authors
-- Create new author
INSERT INTO Authors (first_name, last_name)
VALUES (:first_name_input, :last_name_input);
-- Read Authors name for search drop down
SELECT first_name,last_name FROM Authors
-- Update authors info
UPDATE Authors SET first_name = :first_name, last_name = :last_name WHERE authorID = :author_id_from_update_form
-- Delete author
DELETE FROM Authors WHERE authorID = :author_id_from_delete_form

--
-- Manipuation for Students
-- Manage Students page requires SELECT, INSERT, DELETE, UPDATE
--

-- Query to display studentID, first_name, last_name, and email for all students
SELECT * FROM Students;

--Query to select studentID, first_name, last_name, and email based on studentID
SELECT studentID, first_name, last_name, email FROM Students WHERE studentID = :studentID;

-- Query to insert new student into Students table
INSERT INTO Students (first_name, last_name, email)
VALUES (:first_name_input, :last_name_input, :email_input);

-- Query to delete a student based on studentID
DELETE FROM Students WHERE studentID = :studentID;

-- Query to update a student's first_name, last_name, or email
UPDATE Students
SET first_name = :first_name_input, last_name = :last_name_input, email = :email_input
WHERE studentID = :studentID_input;

--
-- Manipuation for Books_On_Loan
-- Books on Loan page requires SELECT, INSERT, DELETE, UPDATE
--

-- Query to display info of a book rental
SELECT loanID, Books.title, 
Books_On_Loan.studentID, Students.first_name, Students.last_name,
date_checkout, date_due, date_returned, late_fee
FROM Books_On_Loan
INNER JOIN Books ON Books_On_Loan.bookID = Books.bookID
INNER JOIN Students ON Books_On_Loan.studentID = Students.studentID
ORDER BY loanID

-- Query to create a new loaned book
INSERT INTO Books_On_Loan (bookID, studentID, date_checkout, date_due, date_returned, late_fee)
VALUES (:bookID, :studentID, :date_checkout, :date_due, :date_returned, :late_fee);

-- Query to delete a book on loan
DELETE FROM Books_On_Loan WHERE loanID = :loanID;

-- Query to update a book on loan. Only allowing date_due and date_returned to be updated.
-- User would need to delete/create new loan if critical data needs to be changed
-- This helps ensure integrity so that late fees, students, etc. cannot be changed randomly or unknowingly
UPDATE Books_On_Loan
SET date_due = :date_due_input, date_returned = :date_returned_input
WHERE loanID = :loanID_input;
