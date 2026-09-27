{/* Sprint 3: Read Operations (Queries)
    - Get all books 
    - Get a book by title
    - Get all books by a specific author
    - Get all available books
 */}

-- Get all books 
SELECT * FROM books;

-- Get a book by title
SELECT * FROM books
WHERE title = '1984';

-- Get all books by a specific author
SELECT books.*
FROM books
JOIN authors ON books.author_id = authors.id
WHERE authors.name = 'George Orwell';

-- Get all available books
SELECT * FROM books
WHERE available = TRUE

{/* Sprint 4: update Operations 
    - Mark a book as borrowed (set available = false)
    - Add a new genre to an existing book
    - Add a borrowed book to a patron's record
*/}

-- Mark a book as borrowed
UPDATE books
SET available = FALSE
WHERE id = 3;

-- Add a new genre to an existing book
UPDATE books
SET genres = array_append(genres, 'Classic')
WHERE id = 3
AND NOT ('Classic' = ANY(COALESCE(genres, ARRAY[]::TEXT[])));

-- Add a borrowed book to a patron's record
UPDATE patrons
SET borrowed_books = array_append(borrowed_books, 3)
WHERE id = 2
AND NOT (3 = ANY(COALESCE(borrowed_books, ARRAY[]::INT[])));

{/* Sprint 5: Delete Operations
    - Delete a book by title
    - Delete an author ID
*/}

-- Delete a book by title
DELETE FROM books
WHERE title = '1984';

-- Delete an author by ID
DELETE FROM authors
WHERE id = 2;

{/* Sprint 6: Advanced Queries
    - Find books published after 1950
    - Find all american authors
    - Set all books as available 
    - Find all books that are available AND published after 1950
    - Find authors whose names contain "George"
    - Increment the published year 1869 by 1 
*/}

-- Find books published after 1950
SELECT * FROM books
WHERE published_year > 1950;

-- 2. Find all American authors.
SELECT * FROM authors
WHERE nationality = 'American';

-- 3. Set all books as available.
UPDATE books
SET available = TRUE;

-- 4. Find available books published after 1950.
SELECT * FROM books
WHERE available = TRUE AND published_year > 1950;

-- 5. Find authors whose names contain "George".
SELECT * FROM authors
WHERE name ILIKE '%George%';

-- 6. Increase the published year from 1869 to 1870.
UPDATE books
SET published_year = published_year + 1
WHERE published_year = 1869;