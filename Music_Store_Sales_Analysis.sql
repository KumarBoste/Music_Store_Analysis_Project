-- 🎵 Music Store Sales Analysis Project
-- Complete SQL Script (Tables + Sample Data + Queries)

CREATE DATABASE IF NOT EXISTS MusicStoreDB;
USE MusicStoreDB;

-- 1️⃣ Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

-- 2️⃣ Albums Table
CREATE TABLE IF NOT EXISTS Albums (
    album_id INT PRIMARY KEY,
    title VARCHAR(100),
    artist VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(5,2)
);

-- 3️⃣ Sales Table
CREATE TABLE IF NOT EXISTS Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    album_id INT,
    sale_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (album_id) REFERENCES Albums(album_id)
);

-- 4️⃣ Payments Table
CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT PRIMARY KEY,
    sale_id INT,
    amount DECIMAL(6,2),
    payment_mode VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id)
);

-- Insert Data into Customers
INSERT INTO Customers VALUES
(1, 'Aarav Sharma', 'aarav@gmail.com', 'Delhi', 'India'),
(2, 'Sophia Brown', 'sophia@gmail.com', 'London', 'UK'),
(3, 'Liam Johnson', 'liamj@gmail.com', 'New York', 'USA'),
(4, 'Emma Davis', 'emma.davis@gmail.com', 'Sydney', 'Australia'),
(5, 'Rohan Patel', 'rohanp@gmail.com', 'Mumbai', 'India'),
(6, 'Olivia Smith', 'olivia.s@gmail.com', 'Toronto', 'Canada'),
(7, 'Lucas White', 'lucasw@gmail.com', 'Chicago', 'USA');

-- Insert Data into Albums
INSERT INTO Albums VALUES
(101, 'Echoes of Life', 'Arijit Singh', 'Pop', 450.00),
(102, 'Rock Revolution', 'Imagine Dragons', 'Rock', 600.00),
(103, 'Jazz Nights', 'John Coltrane', 'Jazz', 550.00),
(104, 'Country Roads', 'John Denver', 'Country', 400.00),
(105, 'HipHop Vibes', 'Eminem', 'HipHop', 650.00),
(106, 'Classic Melodies', 'Lata Mangeshkar', 'Classical', 300.00),
(107, 'Soulful Strings', 'Yanni', 'Instrumental', 500.00);

-- Insert Data into Sales
INSERT INTO Sales VALUES
(1001, 1, 101, '2025-01-10', 2),
(1002, 2, 102, '2025-01-15', 1),
(1003, 3, 103, '2025-02-05', 3),
(1004, 4, 104, '2025-02-20', 1),
(1005, 5, 105, '2025-03-02', 2),
(1006, 1, 106, '2025-03-10', 1),
(1007, 6, 107, '2025-03-15', 1),
(1008, 7, 102, '2025-03-20', 2),
(1009, 3, 105, '2025-04-05', 1),
(1010, 5, 101, '2025-04-10', 2);

-- Insert Data into Payments
INSERT INTO Payments VALUES
(501, 1001, 900.00, 'Credit Card', '2025-01-10'),
(502, 1002, 600.00, 'PayPal', '2025-01-15'),
(503, 1003, 1650.00, 'Debit Card', '2025-02-05'),
(504, 1004, 400.00, 'Credit Card', '2025-02-20'),
(505, 1005, 1300.00, 'UPI', '2025-03-02'),
(506, 1006, 300.00, 'PayPal', '2025-03-10'),
(507, 1007, 500.00, 'Credit Card', '2025-03-15'),
(508, 1008, 1200.00, 'UPI', '2025-03-20'),
(509, 1009, 650.00, 'PayPal', '2025-04-05'),
(510, 1010, 900.00, 'UPI', '2025-04-10');

-- ✅ Simple Queries
SELECT * FROM Customers WHERE country = 'India';
SELECT SUM(quantity) AS total_albums_sold FROM Sales;
SELECT title, artist FROM Albums WHERE genre = 'Rock';
SELECT s.sale_id, c.name, a.title, s.quantity, s.sale_date
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Albums a ON s.album_id = a.album_id;
SELECT * FROM Payments WHERE payment_mode = 'PayPal';

-- 🚀 Advanced Queries
SELECT a.title, a.artist, SUM(s.quantity) AS total_sold
FROM Sales s
JOIN Albums a ON s.album_id = a.album_id
GROUP BY a.title, a.artist
ORDER BY total_sold DESC
LIMIT 3;

SELECT a.genre, SUM(p.amount) AS total_revenue
FROM Payments p
JOIN Sales s ON p.sale_id = s.sale_id
JOIN Albums a ON s.album_id = a.album_id
GROUP BY a.genre
ORDER BY total_revenue DESC;

SELECT c.name, SUM(p.amount) AS total_spent
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
JOIN Payments p ON s.sale_id = p.sale_id
GROUP BY c.name
HAVING total_spent > 2000
ORDER BY total_spent DESC;

SELECT DATE_FORMAT(p.payment_date, '%Y-%m') AS month, SUM(p.amount) AS monthly_revenue
FROM Payments p
GROUP BY month
ORDER BY month;

SELECT c.country, a.genre, COUNT(*) AS total_sales
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Albums a ON s.album_id = a.album_id
GROUP BY c.country, a.genre;
