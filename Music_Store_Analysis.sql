/*
Project Title: Music_Store_Analysis SQL Project
Prepared by : Kumar Balaram Boste

-- Introduction: The Music Store Analysis project simulates a real-world database for an online/offline music store.
It contains information about artists, albums, tracks, playlists, customers, employees, invoices, and sales.
This project helps in analyzing customer preferences, sales performance, popular tracks, and employee management.

Objective :  To design a relational database for managing a music store.
			 To analyze customer purchasing patterns.
			 To track sales by genre, artist, and album.
			 To generate insights on playlists and track usage.
			 To support decision-making for business growth.

Database Schema Tables:  artist- artist information,
						 album – Albums with reference to artist,
						 track – Songs with album, genre, media type,
						 genre – Track genres,
						 media_type – Media format of tracks,
						 playlist – Playlists created,
						 playlist_track – Linking playlists with tracks,
						 customer – Customer details,
					 	 employee – Employee details,
						 invoice – Customer purchases,
						 invoice_line – Items sold in each invoice;
*/
-- Create Database : Music_Store_Analysis

-- 1. Artist
CREATE TABLE artist (
    artist_id SERIAL PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL
);

-- 2. Album
CREATE TABLE album (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    artist_id INT REFERENCES artist(artist_id)
);

-- 3. Genre
CREATE TABLE genre (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL
);

-- 4. Media Type
CREATE TABLE media_type (
    media_type_id SERIAL PRIMARY KEY,
    mediatype_name VARCHAR(100) NOT NULL
);

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

-- 6. Playlist
CREATE TABLE playlist (
    playlist_id SERIAL PRIMARY KEY,
    playlist_name VARCHAR(100)
);

-- 7. Playlist Track
CREATE TABLE playlist_track (
    playlist_id INT REFERENCES playlist(playlist_id),
    track_id INT REFERENCES track(track_id),
    PRIMARY KEY (playlist_id, track_id)
);

-- 8. Customer
CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    country VARCHAR(50)
);

-- 9. Employee
CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    title VARCHAR(50),
    reports_to INT REFERENCES employee(employee_id)
);

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

-- 11. Invoice Line
CREATE TABLE invoice_line (
    invoice_line_id SERIAL PRIMARY KEY,
    invoice_id INT REFERENCES invoice(invoice_id),
    track_id INT REFERENCES track(track_id),
    unit_price NUMERIC(5,2),
    quantity INT
);

-- Inserting Records in Tables :

-- Inserting Records in Tables(10-Each)

-- Artist
INSERT INTO artist (artist_name) VALUES
('The Beatles'),
('Adele'),
('Ed Sheeran'),
('Eminem'),
('Taylor Swift'),
('Coldplay'),
('Linkin Park'),
('Drake'),
('BTS'),
('Arijit Singh');


-- Album
INSERT INTO album (title, artist_id) VALUES
('Abbey Road',1),
('25',2),
('Divide',3),
('Revival',4),
('1989',5),
('Parachutes',6),
('Hybrid Theory',7),
('Scorpion',8),
('Map of the Soul',9),
('Tum Hi Ho',10);

-- Genre
INSERT INTO genre (genre_name) VALUES
('Rock'),
('Pop'),
('Hip Hop'),
('R&B'),
('Classical'),
('Jazz'),
('Metal'),
('EDM'),
('Bollywood'),
('Country');

-- Media Type
INSERT INTO media_type (mediatype_name) VALUES
('MP3'),
('WAV'),
('AAC'),
('FLAC'),
('Vinyl'),
('CD'),
('Cassette'),
('DVD'),
('Digital'),
('Streaming');

-- Track
INSERT INTO track (track_name, album_id, media_type_id, genre_id, composer, milliseconds, bytes, unit_price) VALUES
('Come Together',1,1,1,'Lennon',259000,5000000,1.29),
('Hello',2,2,2,'Adele',295000,6000000,1.49),
('Shape of You',3,1,2,'Ed Sheeran',263000,5500000,1.19),
('Lose Yourself',4,3,3,'Eminem',326000,7000000,1.39),
('Blank Space',5,1,2,'Taylor Swift',231000,4800000,1.29),
('Yellow',6,4,1,'Coldplay',270000,5100000,1.19),
('In the End',7,1,1,'Linkin Park',217000,4900000,1.29),
('God’s Plan',8,2,3,'Drake',210000,4600000,1.49),
('Boy With Luv',9,1,2,'BTS',230000,4700000,1.29),
('Tum Hi Ho',10,1,9,'Mithoon',245000,5000000,0.99);

-- Playlist
INSERT INTO playlist (playlist_name) VALUES
('Rock Classics'),
('Pop Hits'),
('Hip Hop Vibes'),
('Romantic'),
('Workout'),
('Chillout'),
('Party Mix'),
('Jazz Essentials'),
('Bollywood Blast'),
('Top 10');

-- Playlist Track
INSERT INTO playlist_track VALUES
(1,1),
(2,2),
(2,3),
(3,4),
(2,5),
(1,6),
(1,7),
(3,8),
(2,9),
(9,10);

-- Customer
INSERT INTO customer (first_name, last_name, email, phone, country) VALUES
('John','Doe','john@example.com','1234567890','USA'),
('Jane','Smith','jane@example.com','2345678901','UK'),
('Raj','Kumar','raj@example.com','3456789012','India'),
('Emily','Clark','emily@example.com','4567890123','Canada'),
('Carlos','Lopez','carlos@example.com','5678901234','Mexico'),
('Sophia','Brown','sophia@example.com','6789012345','Australia'),
('Ali','Khan','ali@example.com','7890123456','UAE'),
('Anna','Ivanova','anna@example.com','8901234567','Russia'),
('Yuki','Tanaka','yuki@example.com','9012345678','Japan'),
('Sara','Lee','sara@example.com','1122334455','South Korea');

-- Employee
INSERT INTO employee (first_name, last_name, title, reports_to) VALUES
('Mark','Johnson','Manager',1),
('Lisa','Taylor','Sales Rep',1),
('Robert','Miller','Sales Rep',1),
('David','Wilson','IT Support',1),
('Maria','Garcia','Sales Rep',1),
('James','Brown','HR',1),
('Karen','Davis','Finance',1),
('Daniel','Martinez','Marketing',1),
('Laura','White','Sales Rep',1),
('Kevin','Anderson','Sales Rep',1);

-- Invoice
INSERT INTO invoice (customer_id, invoice_date, billing_address, billing_city, billing_country, total) VALUES
(1,'2023-01-10','123 Main St','New York','USA',15.00),
(2,'2023-02-14','45 Queen St','London','UK',12.50),
(3,'2023-03-21','MG Road','Delhi','India',8.99),
(4,'2023-04-11','Maple Ave','Toronto','Canada',20.00),
(5,'2023-05-09','Reforma 100','Mexico City','Mexico',10.50),
(6,'2023-06-15','George St','Sydney','Australia',13.20),
(7,'2023-07-20','Sheikh Zayed Rd','Dubai','UAE',25.00),
(8,'2023-08-18','Lenin St','Moscow','Russia',7.80),
(9,'2023-09-25','Shibuya','Tokyo','Japan',18.75),
(10,'2023-10-05','Gangnam','Seoul','South Korea',14.40);

-- Invoice Line
INSERT INTO invoice_line (invoice_id, track_id, unit_price, quantity) VALUES
(1,1,1.29,2),
(1,3,1.19,3),
(2,2,1.49,2),
(3,10,0.99,5),
(4,4,1.39,2),
(5,5,1.29,3),
(6,6,1.19,2),
(7,7,1.29,4),
(8,8,1.49,1),
(9,9,1.29,3),
(10,1,1.29,1),
(10,2,1.49,2);

-- SQL QUERIES : 
-- 1. List all customers Employee
SELECT * FROM customer;

-- 2. Get all tracks with price greater than 1.20
SELECT track_name, unit_price
FROM track
WHERE unit_price > 1.20;



-- 3. Find all albums by 'Ed Sheeran'
SELECT a.title 
FROM album a
JOIN artist ar ON a.artist_id = ar.artist_id
WHERE artist_name = 'Ed Sheeran';


-- 4. Count total customers from India
SELECT COUNT(*) 
FROM customer
WHERE country='India';

-- 5. Display all employees who are Sales Reps
SELECT first_name, last_name 
FROM employee 
WHERE title='Sales Rep';

-- 6. Find the total number of tracks per genre
SELECT genre_name, COUNT(t.track_id) AS total_tracks
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
GROUP BY genre_name;


-- 7. Show invoice details along with customer names
SELECT i.invoice_id, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

-- 8. Find top 5 most expensive tracks
SELECT track_name, unit_price
FROM track
ORDER BY unit_price DESC
LIMIT 5;


-- 9. Show all playlists with track count
SELECT playlist_name, COUNT(pt.track_id) AS track_count
FROM playlist p
JOIN playlist_track pt ON p.playlist_id = pt.playlist_id
GROUP BY playlist_name;

-- 10. Find customers who spent more than 15
SELECT c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
HAVING SUM(i.total) > 15;

-- 11. Find the best-selling track
SELECT track_name, SUM(il.quantity) AS total_sold
FROM track t
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY t.track_id, t.track_name
ORDER BY total_sold DESC
LIMIT 1;

-- 12. Find top 3 artists by sales revenue
SELECT artist_name, SUM(il.unit_price * il.quantity) AS revenue
FROM artist ar
JOIN album al ON ar.artist_id = al.artist_id
JOIN track t ON al.album_id = t.album_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY artist_name
ORDER BY revenue DESC
LIMIT 3;

-- 13. Find the most popular genre based on track purchases
SELECT genre_name, SUM(il.quantity) AS total_sold
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY genre_name
ORDER BY total_sold DESC
LIMIT 1;

-- 14. Get the top customer by spending
SELECT c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;

-- 15. Find employee with maximum customers handled
SELECT e.first_name, e.last_name, COUNT(DISTINCT i.customer_id) AS customers_handled
FROM employee e
JOIN customer c ON e.employee_id = (c.customer_id % 5) + 2  -- dummy mapping
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY customers_handled DESC
LIMIT 1;

-- 16. Find the top 3 customers by total invoices and their spending
SELECT c.customer_id, c.first_name, c.last_name,
       COUNT(i.invoice_id) AS total_invoices,
       SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 3;

-- 17. Find the average track length (milliseconds) per genre
SELECT genre_name AS genre, AVG(t.milliseconds) AS avg_length
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY genre_name
ORDER BY avg_length DESC;

-- 18. Rank artists by total revenue
SELECT ar.artist_id, artist_name,
       SUM(il.unit_price * il.quantity) AS revenue,
       RANK() OVER (ORDER BY SUM(il.unit_price * il.quantity) DESC) AS rank_position
FROM artist ar
JOIN album al ON ar.artist_id = al.artist_id
JOIN track t ON al.album_id = t.album_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY ar.artist_id;


