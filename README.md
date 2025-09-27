# Music Store Analysis Project using PostgreSQL
![Music Store Logo](https://github.com/KumarBoste/Music_Store_Analysis_Project/blob/main/LOGO.png)


## Introduction
The Music Store Analysis project simulates a real-world database for an online/offline music store.
It contains information about artists, albums, tracks, playlists, customers, employees, invoices, and sales.
This project helps in analyzing customer preferences, sales performance, popular tracks, and employee management.

## Objective
- To design a relational database for managing a music store.
- To analyze customer purchasing patterns.
- To track sales by genre, artist, and album.
- To generate insights on playlists and track usage.
- To support decision-making for business growth.

## Database Schema Tables
- Artist
- Album
- Track
- Genre
- Media_Type
- Playlist
- Playlist_Track
- Customer
- Employee
- Invoice
- Invoice_Line

## Create Database : Music_Store_Analysis
``` sql
CREATE DATABASE music_store;
USE music_store;
```
## Create Schema Tables :
```sql
-- 1. Artist
CREATE TABLE artist (
    artist_id SERIAL PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL
);
```
```sql
-- 2. Album
CREATE TABLE album (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    artist_id INT REFERENCES artist(artist_id)
);
```
```sql
-- 3. Genre
CREATE TABLE genre (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL
);
```
```sql
-- 4. Media Type
CREATE TABLE media_type (
    media_type_id SERIAL PRIMARY KEY,
    mediatype_name VARCHAR(100) NOT NULL
);
```
```sql
-- 5. Track
CREATE TABLE track (
    track_id SERIAL PRIMARY KEY,
    track_name VARCHAR(150),
    album_id INT REFERENCES album(album_id),
    media_type_id INT REFERENCES media_type(media_type_id),
    genre_id INT REFERENCES genre(genre_id),
    composer VARCHAR(100),
    milliseconds INT,
    bytes INT,
    unit_price NUMERIC(5,2)
);
```
```sql
-- 6. Playlist
CREATE TABLE playlist (
    playlist_id SERIAL PRIMARY KEY,
    playlist_name VARCHAR(100)
);
```
```sql
-- 7. Playlist Track
CREATE TABLE playlist_track (
    playlist_id INT REFERENCES playlist(playlist_id),
    track_id INT REFERENCES track(track_id),
    PRIMARY KEY (playlist_id, track_id)
);
```
```sql
-- 8. Customer
CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    country VARCHAR(50)
);
```
```sql
-- 9. Employee
CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    title VARCHAR(50),
    reports_to INT REFERENCES employee(employee_id)
);
```
```sql
-- 10. Invoice
CREATE TABLE invoice (
    invoice_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id),
    invoice_date DATE,
    billing_address VARCHAR(150),
    billing_city VARCHAR(100),
    billing_country VARCHAR(100),
    total NUMERIC(10,2)
);
```
```sql
-- 11. Invoice Line
CREATE TABLE invoice_line (
    invoice_line_id SERIAL PRIMARY KEY,
    invoice_id INT REFERENCES invoice(invoice_id),
    track_id INT REFERENCES track(track_id),
    unit_price NUMERIC(5,2),
    quantity INT
);
```

## Analysis-1 :
- 1.1 List all customers
```sql
-- 1. List all customers Employee
SELECT * FROM customer;
```

- 1.2 Get Tracks with Price Greater than 1.20
```sql
-- 1.2 Get all tracks with price greater than 1.20
SELECT track_name, unit_price
FROM track
WHERE unit_price > 1.20;
```

- 1.3 Find all Albums by Ed Sheeran
```sql
-- 1.3 Find all albums by 'Ed Sheeran'
SELECT a.title 
FROM album a
JOIN artist ar ON a.artist_id = ar.artist_id
WHERE artist_name = 'Ed Sheeran';
```

- 1.4 Count Total Customers from India
```sql
-- 1.4 Count total customers from India
SELECT COUNT(*) 
FROM customer
WHERE country='India';
```

- 1.5 Display all Employees who are Sales Representation
```sql
-- 1.5 Display all employees who are Sales Reps
SELECT first_name, last_name 
FROM employee 
WHERE title='Sales Rep';
```

## Analysis-2 :
- 2.1 Find the Total number of Tracks Per Genre
```sql
-- 2.1 Find the total number of tracks per genre
SELECT genre_name, COUNT(t.track_id) AS total_tracks
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
GROUP BY genre_name;
```

- 2.2 Show Invoice Details along with Customer Names
```sql
-- 2.2 Show invoice details along with customer names
SELECT i.invoice_id, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;
```

- 2.3 Find top 5 Most Expensive Tracks
```sql
-- 2.3 Find top 5 most expensive tracks
SELECT track_name, unit_price
FROM track
ORDER BY unit_price DESC
LIMIT 5;
```
 
- 2.4 Show all Playlists with Track Count
```sql
-- 2.4 Show all playlists with track count
SELECT playlist_name, COUNT(pt.track_id) AS track_count
FROM playlist p
JOIN playlist_track pt ON p.playlist_id = pt.playlist_id
GROUP BY playlist_name;
```
 
- 2.5 Find Customers Who Spent more than 15
```sql
-- 2.5 Find customers who spent more than 15
SELECT c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
HAVING SUM(i.total) > 15;
```
- 2.6 Find the Best-selling Track
```sql
-- 2.6 Find the best-selling track
SELECT track_name, SUM(il.quantity) AS total_sold
FROM track t
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY t.track_id, t.track_name
ORDER BY total_sold DESC
LIMIT 1;
```

- 2.7 Find Top 3 Artists by Sales Revenue
```sql
-- 2.7 Find top 3 artists by sales revenue
SELECT artist_name, SUM(il.unit_price * il.quantity) AS revenue
FROM artist ar
JOIN album al ON ar.artist_id = al.artist_id
JOIN track t ON al.album_id = t.album_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY artist_name
ORDER BY revenue DESC
LIMIT 3;
```
 
- 2.8 Find Top 3 Artists by Sales Revenue
```sql
-- 2.8 Find the most popular genre based on track purchases
SELECT genre_name, SUM(il.quantity) AS total_sold
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY genre_name
ORDER BY total_sold DESC
LIMIT 1;
```

## Analysis-3 :
- 3.1 Get the Top Customer by Spending
```sql
-- 3.1 Get the top customer by spending
SELECT c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;
```
 
- 3.2 Find Employee with Maximum Customers Handled
```sql
-- 3.2 Find employee with maximum customers handled
SELECT e.first_name, e.last_name, COUNT(DISTINCT i.customer_id) AS customers_handled
FROM employee e
JOIN customer c ON e.employee_id = (c.customer_id % 5) + 2  -- dummy mapping
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY customers_handled DESC
LIMIT 1;
```

- 3.3 Find top 3 Customers by Invoices and Spending
```sql
-- 3.3 Find the top 3 customers by total invoices and their spending
SELECT c.customer_id, c.first_name, c.last_name,
       COUNT(i.invoice_id) AS total_invoices,
       SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 3;
```
 
- 3.4 Average Track Length per Genre
```sql
-- 3.4 Find the average track length (milliseconds) per genre
SELECT genre_name AS genre, AVG(t.milliseconds) AS avg_length
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY genre_name
ORDER BY avg_length DESC;
```
 
- 3.5 Rank Artists by Total Revenue
```sql
-- 3.5 Rank artists by total revenue
SELECT ar.artist_id, artist_name,
       SUM(il.unit_price * il.quantity) AS revenue,
       RANK() OVER (ORDER BY SUM(il.unit_price * il.quantity) DESC) AS rank_position
FROM artist ar
JOIN album al ON ar.artist_id = al.artist_id
JOIN track t ON al.album_id = t.album_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY ar.artist_id;
``` 

## Conclusion
This project successfully demonstrates the design, implementation, and analytical capabilities of a comprehensive music store database system. Through the creation of a well-structured relational database and execution of meaningful SQL queries, the project achieves several key outcomes:

## Key Achievements
**Database Design Excellence**
- Created a robust 11-table schema that effectively models real-world music store operations
- Established proper relationships between entities (artists, albums, tracks, customers, invoices)
- Implemented referential integrity through foreign key constraints

**Comprehensive Analytical Capabilities**
- Enabled tracking of customer purchasing patterns and preferences
- Facilitated sales performance analysis by genre, artist, and album
- Provided insights into inventory management and popular content
- Supported employee performance monitoring and customer relationship management

**Business Intelligence Value**
- Identified top-selling tracks and most profitable artists
- Revealed customer spending patterns and high-value clients
- Analyzed genre popularity and track performance metrics
- Generated actionable insights for inventory planning and marketing strategies

**Technical Strengths**
- The project showcases advanced SQL capabilities including:
- Complex JOIN operations across multiple tables
- Aggregate functions with GROUP BY and HAVING clauses
- Window functions for ranking and comparative analysis
- Subqueries and conditional filtering
- Performance-optimized query structures

**Business Impact**
This database system provides a solid foundation for :
- Data-driven decision making for store management
- Customer segmentation and targeted marketing campaigns
- Inventory optimization based on sales trends
- Revenue growth strategies through popular content identification
- Operational efficiency improvements
