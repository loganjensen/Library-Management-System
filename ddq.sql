-- Authors: Logan Jensen and Chris Brensier
-- Date: May 18, 2020
-- Course: CS 340
-- Section: 401
-- Group: 36
-- Project Title: Library Loan-System Database

DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Genres;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Books_On_Loan;

--
--
-- Data Definition Queries
--
--

--
-- Authors Table
-- This table holds information about the author of a book,
-- and a book uses a FK to link to author/authors.
--
CREATE TABLE Authors (
    authorID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL
) ENGINE=INNODB DEFAULT CHARSET=latin1;

--
-- Genres Table
-- This table holds information about books genres,
-- and a book uses a FK to link to genre/genres.
--
CREATE TABLE Genres (
    genreID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    genre_name varchar(255) UNIQUE NOT NULL
) ENGINE=INNODB DEFAULT CHARSET=latin1;

--
-- Books Table
-- This table holds information about books available in the library.
-- Each book has author(s) and genre(s), and these book entities are used to track book loans.
--
CREATE TABLE Books (
    bookID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title varchar(255) NOT NULL,
    year_published year NOT NULL,
    authorID int NOT NULL,
    genreID int NOT NULL,
    CONSTRAINT Books_fk1 FOREIGN KEY (authorID) REFERENCES Authors (authorID),
    CONSTRAINT Books_fk2 FOREIGN KEY (genreID) REFERENCES Genres (genreID)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

--
-- Students Table
-- This table holds information about students on campus.
-- When loaning a book, a student entity will be linked with a book entity to track
-- which students have which books.
--
-- Note: email data type informed by https://dba.stackexchange.com/questions/37014/in-what-data-type-should-i-store-an-email-address-in-database
CREATE TABLE Students (
    studentID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    email nvarchar(320) UNIQUE NOT NULL
) ENGINE=INNODB DEFAULT CHARSET=latin1;

--
-- Books_On_Loan Table
-- This table holds information about book loans.
-- Each loan has one student and one book and tracks information related to that loan.
--
CREATE TABLE Books_On_Loan (
    loanID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bookID int NOT NULL,
    studentID int NOT NULL,
    date_checkout date NOT NULL,
    date_due date NOT NULL,
    date_returned date,
    late_fee float NOT NULL,
    CONSTRAINT Books_On_Loan_fk1 FOREIGN KEY (bookID) REFERENCES Books (bookID),
    CONSTRAINT Books_On_Loan_fk2 FOREIGN KEY (studentID) REFERENCES Students (studentID)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

--
--
--  Sample Data
--
--

--
-- Authors Sample Data
--
INSERT INTO Authors (first_name, last_name) VALUES ('Stephen', 'King');
INSERT INTO Authors (first_name, last_name) VALUES ('Mark', 'Twain');
INSERT INTO Authors (first_name, last_name) VALUES ('Charles', 'Dickens');
INSERT INTO Authors (first_name, last_name) VALUES ('Jane', 'Austen');
INSERT INTO Authors (first_name, last_name) VALUES ('Agatha', 'Christie');

--
-- Genres Sample Data
--
INSERT INTO Genres (genre_name) VALUES ('Adventure');
INSERT INTO Genres (genre_name) VALUES ('Autobiography');
INSERT INTO Genres (genre_name) VALUES ('Mystery');
INSERT INTO Genres (genre_name) VALUES ('Memoir');
INSERT INTO Genres (genre_name) VALUES ('Satire');

--
-- Books Sample Data
--
INSERT INTO Books (title, year_published, authorID, genreID) VALUES ('It', '1986', '1', '3');
INSERT INTO Books (title, year_published, authorID, genreID) VALUES ('The Shining', '1977', '1', '3');
INSERT INTO Books (title, year_published, authorID, genreID) VALUES ('The Hollow', '1946', '5', '1');
INSERT INTO Books (title, year_published, authorID, genreID) VALUES ('Emma', '1905', '4', '2');
INSERT INTO Books (title, year_published, authorID, genreID) VALUES ('Oliver Twist', '1930', '3', '5');

--
-- Students Sample Data
--
INSERT INTO Students (first_name, last_name, email) VALUES ('Bob', 'Johnson', 'johnson@fake.edu');
INSERT INTO Students (first_name, last_name, email) VALUES ('Stacey', 'Wendinger', 'wendinger@fake.edu');
INSERT INTO Students (first_name, last_name, email) VALUES ('Jennifer', 'Ungmeyer', 'ungmeyer@fake.edu');
INSERT INTO Students (first_name, last_name, email) VALUES ('Moira', 'Rose', 'rose@fake.edu');
INSERT INTO Students (first_name, last_name, email) VALUES ('Sara', 'Peter', 'peter@fake.edu');

--
-- Books_On_Loan Sample Data
--
INSERT INTO Books_On_Loan (bookID, studentID, date_checkout, date_due, date_returned, late_fee) VALUES ('1', '5', '2020-01-01', '2020-02-01', '2020-01-29', '20');
INSERT INTO Books_On_Loan (bookID, studentID, date_checkout, date_due, date_returned, late_fee) VALUES ('2', '4', '2020-02-01', '2020-02-09', '2020-02-07', '20');
INSERT INTO Books_On_Loan (bookID, studentID, date_checkout, date_due, date_returned, late_fee) VALUES ('3', '3', '2020-03-03', '2020-03-15', '2020-03-12', '20');
INSERT INTO Books_On_Loan (bookID, studentID, date_checkout, date_due, date_returned, late_fee) VALUES ('4', '2', '2020-04-18', '2020-04-29', '2020-04-24', '20');
INSERT INTO Books_On_Loan (bookID, studentID, date_checkout, date_due, date_returned, late_fee) VALUES ('5', '1', '2020-05-13', '2020-05-30', '2020-5-19', '20');