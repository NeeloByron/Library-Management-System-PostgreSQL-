# Library Management System (PostgreSQL)

A relational database project implemented in *PostgreSQL* to manage a collection of books, authors and library patrons. This project contains the complete database schema, data seeding scripts and operational queries categorized across several development sprints.

## Project Structure
- `Schema.sql` - Definitions for tables, primary keys and foreign key relationships.
- `Seed.sql` - Pre-populated sample data for books, authors and patrons.
- `Queries.sql` - Operational CRUD transactions and advanced data analysis queries.
- `README.md` - Setup and execution instructions.

# Database schama Design 

The system implements a relational schema mapping out the data dependencies between books, authors and borrowing patrons.


```
  ┌───────────────┐              ┌───────────────┐
  │    AUTHORS    │              │     BOOKS     │
  ├───────────────┤              ├───────────────┤
  │ PK │ id       │◄───┐         │ PK │ id       │
  │    │ name     │    └─────────┼─FK │ author_id│
  │    │ ...      │              │    │ title    │
  └───────────────┘              │    │ ...      │
                                 └───────────────┘
  ┌───────────────┐
  │    PATRONS    │
  ├───────────────┤
  │ PK │ id       │
  │    │ name     │
  │    │ array[]  │ ──(Tracks borrowed book IDs)
  └───────────────┘
```

## Setup 
 
 The database is using **pgAdmin**

 ### Using pgAdmin 4
 1. Right click on **Databases** -> **Create** -> **Database...** and name it `LibraryDB`.
 2. Right click on the newly created `LibraryDB` and select **Query Tool**.
 3. Open and execute the contents of `schema.sql`, followed by `seed.sql`.
 4. Use the Query Tool to run specific statements out of `queries.sql`.

  ## SQL Script Reference 
  
  ### 1. Schema Definition (`schema.sql`)
```sql
-- Create Authors Table
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    nationality VARCHAR(100),
    birth_year INT,
    death_year INT
);

-- Create Books Table
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT REFERENCES authors(id) ON DELETE CASCADE,
    genres TEXT[],
    published_year INT,
    available BOOLEAN DEFAULT TRUE
);

-- Create Patrons Table
CREATE TABLE patrons (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255_UNIQUE NOT NULL,
    borrowed_books INT[] DEFAULT ARRAY[]::INT[]
);
```

### 2. Core Operations & Advanced Queries (`queries.sql`)
Below is a sampling of the sprint operations documented in the transaction script:

```sql
-- Sprint 3: View books by specific author (e.g., George Orwell, ID = 1)
SELECT * FROM books WHERE author_id = 1;

-- Sprint 4: Track a transaction when Patron 2 borrows Book 3
UPDATE books SET available = FALSE WHERE id = 3;
UPDATE patrons SET borrowed_books = array_append(borrowed_books, 3) WHERE id = 2;

-- Sprint 6: Find all available books published after 1950
SELECT * FROM books WHERE available = TRUE AND published_year > 1950;
```
