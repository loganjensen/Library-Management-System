-- Authors: Logan Jensen and Christopher Breniser
-- Date: May 18, 2020
-- Course: CS 340
-- Section: 401
-- Group: 36
-- Project Title: Library Loan-System Database
--------------------------------------------------------

-- a) Data Definition Queries

DROP TABLE IF EXISTS `Books`;
CREATE TABLE `Books` (
    `bookID` int NOT NULL AUTO-INCREMENT PRIMARY KEY,
    `title` varchar(255) NOT NULL,
    `year_published` year NOT NULL,
    `authorID` int NOT NULL,
    `genreID` int NOT NULL,
    CONSTRAINT `Books_fk1` FOREIGN KEY (`authorID`) REFERENCES `Authors` (`authorID`),
    CONSTRAINT `Books_fk2` FOREIGN KEY (`genreID`) REFERENES `Genres` (`genreID`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Students`;
CREATE TABLE `Students` (
    `studentID` int NOT NULL AUTO-INCREMENT PRIMARY KEY,
    `first_name` varchar(255) NOT NULL,
    `last_name` varchar(255) NOT NULL,
    `email` nvarchar(320) NOT NULL
) ENGINE=INNODB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Books_On_Loan`;
CREATE TABLE `Books_On_Loan` (
    `loanID` int NOT NULL AUTO-INCREMENT PRIMARY KEY,
    `bookID` int NOT NULL,
    `studentID` int NOT NULL,
    `date_checkout` date NOT NULL,
    `date_due` date NOT NULL,
    `date_returned` date,
    `late_fee` float NOT NULL,
    CONSTRAINT `Books_On_Loan_fk1` FOREIGN KEY (`bookID`) REFERENCES `Books` (`bookID`),
    CONSTRAINT `Books_On_Loan_fk2` FOREIGN KEY (`studentID`) REFERENCES `Students` (`studentID`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Authors`;
CREATE TABLE `Authors` (
    `authorID` int NOT NULL AUTO-INCREMENT PRIMARY KEY,
    `first_name` varchar(255) NOT NULL,
    `last_name` varchar(255) NOT NULL,
) ENGINE=INNODB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Genres`;
CREATE TABLE `Genres` (
    `genreID` int NOT NULL AUTO-INCREMENT PRIMARY KEY,
    `genre_name` varchar(255) UNIQUE NOT NULL,
) ENGINE=INNODB DEFAULT CHARSET=latin1;