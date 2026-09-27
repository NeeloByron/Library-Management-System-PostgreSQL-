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
WHERE title = '1984'l

-- Get all books by a specific author
SELECT books.*
FROM books
JOIN authors ON books.author_id = authors.id
WHERE authors.name = 'George Orwell';

-- Get all available books
SELECT * FROM books
WHERE available = TRUE;