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
- 1.2 Get Tracks with Price Greater than 1.20
- 1.3 Find all Albums by Ed Sheeran 
- 1.4 Count Total Customers from India 
- 1.5 Display all Employees who are Sales Representation
  
### Analysis-2 :
- 2.1 Find the Total number of Tracks Per Genre
- 2.2 Show Invoice Details along with Customer Names
- 2.3 Find top 5 Most Expensive Tracks 
- 2.4 Show all Playlists with Track Count 
- 2.5 Find Customers Who Spent more than 15 
- 2.6 Find the Best-selling Track
- 2.7 Find Top 3 Artists by Sales Revenue 
- 2.8 Find Top 3 Artists by Sales Revenue

### Analysis-3 :
