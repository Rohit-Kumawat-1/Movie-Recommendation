CREATE DATABASE Booking;
Use booking;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);
    
CREATE TABLE screens(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    total_seats INT NOT NULL
);

CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    duration_minutes INT,
    release_date DATE,
    rating VARCHAR(10)
);

CREATE TABLE showtimes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    screen_id INT,
    show_date DATE,
    show_time TIME,
    available_seats INT,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE
);

CREATE TABLE bookings(
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    showtime_id INT,
    seats_booked INT,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (showtime_id) REFERENCES showtimes(id) ON DELETE CASCADE
);

CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Completed',
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
);

CREATE TABLE seats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    screen_id INT,
    seat_number VARCHAR(10),
    seat_type VARCHAR(50),
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE
);

INSERT INTO users (username, password, email, phone) VALUES 
('john_doe', 'password123', 'john@example.com', '1234567890'),
('jane_smith', 'secure456', 'jane@example.com', '9876543210');

INSERT INTO screens (name, total_seats) VALUES 
('Screen 1', 100),
('Screen 2', 80);

INSERT INTO movies (title, genre, duration_minutes, release_date, rating) VALUES 
('Avengers: Endgame', 'Action', 180, '2019-04-26', 'PG-13'),
('Inception', 'Sci-Fi', 148, '2010-07-16', 'PG-13'),
('The Lion King', 'Animation', 118, '2019-07-19', 'PG');

INSERT INTO showtimes (movie_id, screen_id, show_date, show_time, available_seats) VALUES 
(1, 1, '2025-04-27', '18:00:00', 100),
(2, 2, '2025-04-27', '20:00:00', 80),
(3, 1, '2025-04-28', '16:00:00', 100);



INSERT INTO seats (screen_id, seat_number, seat_type) VALUES
(1, 'A1', 'Normal'),
(1, 'A2', 'Normal'),
(1, 'A3', 'VIP'),
(1, 'A4', 'Normal'),
(1, 'A5', 'VIP');

INSERT INTO bookings (user_id, showtime_id, seats_booked) VALUES
(1, 1, 2),
(2, 2, 1);

INSERT INTO payments (booking_id, amount, payment_method) VALUES
(1, 500.00, 'Credit Card'),
(2, 250.00, 'PayPal');

SELECT * FROM users;
SELECT * FROM movies;
SELECT * FROM showtimes;
SELECT * FROM bookings;
SELECT * FROM seats;