-- Authors: Logan Jensen and Christopher Breniser
-- Date: May 18, 2020
-- Course: CS 340
-- Section: 401
-- Group: 36
-- Project Title: Library Loan-System Database
--------------------------------------------------------

-- Books need: Create, Read, Update, Delete
-- Read all entries of books
SELECT * FROM 'Books'
-- Read titles to fill loan a book drop down
SELECT bookID,title FROM 'Books'
-- Read title of book with accociated Author and genre
SELECT bookID, title, year_published, authorID, genreID
FROM 'Books',
INNER JOIN 'Authors' ON Books.authorID = Authors.authorID
INNER JOIN 'Genres' ON Books.genreID = Genres.genreID
ORDER BY Title, year_published


-- Update entry of book
UPDATE 'books' SET 'title' = :title, 'year_published' = :year_published, 'authorID' = :authorID, 'genreID' = :genreID WHERE 'bookID'= :book_id_from_update_form
-- Delete book entry
DELETE FROM 'Books' WHERE id = :book_id_from_delete_form

-- Genres
-- Read all Genres for main list page
SELECT * FROM 'Genres'
-- Read names for search drop down
SELECT genre_name AS genre FROM 'Genres'
-- Update genre info (no planned implementation on the front end)
UPDATE 'Genres' SET 'genre_name' = :genre_name WHERE 'genreID' = :genre_id_from_update_form
-- Delete genre entry
DELETE FROM 'Genres' WHERE 'genreID' = :genre_id_from_delete_form

-- Authors
-- Read all Authors for main list
SELECT * FROM 'Authors'
-- Read Authors name for search drop down
SELECT first_name,last_name FROM 'Authors'
-- Update authors info
UPDATE 'Authors' SET 'first_name' = :first_name, 'last_name' = :last_name WHERE 'authorID' = :author_id_from_update_form
-- Delete author
DELETE FROM 'Authors' WHERE 'authorID' = :author_id_from_delete_form
