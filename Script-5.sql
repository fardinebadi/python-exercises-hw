 
INSERT INTO usersss (name, address, email_adress, phone_number, role) VALUES  
('Alice Johnson', '123 Maple St, Springfield', 'alice@example.com', 1234567890, 'user'),  
('Bob Smith', '456 Oak St, Springfield', 'bob@example.com', 2345678901, 'user'),  
('Charlie Brown', '789 Pine St, Springfield', 'charlie@example.com', 3456789012, 'admim'),  
('Diana Prince', '321 Elm St, Springfield', 'diana@example.com', 4567890123, 'user'),  
('Ethan Hunt', '654 Cedar St, Springfield', 'ethan@example.com', 5678901234, 'admim'),  
('Fiona Gallagher', '987 Birch St, Springfield', 'fiona@example.com', 6789012345, 'user');  

  
INSERT INTO track (name, price, file_size, format) VALUES  
('Track 1', 1.99, 3.5, 'mp3'),  
('Track 2', 2.99, 4.0, 'wav'),  
('Track 3', 3.99, 5.0, 'flac'),  
('Track 4', 1.49, 2.5, 'mp3'),  
('Track 5', 2.49, 3.0, 'aac'),  
('Track 6', 3.49, 6.0, 'ogg');  

 
INSERT INTO artist (name, last_name) VALUES  
('John', 'Doe'),  
('Jane', 'Smith'),  
('Michael', 'Johnson'),  
('Emily', 'Davis'),  
('David', 'Wilson'),  
('Sarah', 'Brown');  

  
INSERT INTO publisher (name, address, description) VALUES  
('Music Publisher 1', '123 Music Ave', 'A leading music publisher.'),  
('Music Publisher 2', '456 Sound Blvd', 'Specializes in indie music.'),  
('Music Publisher 3', '789 Tune Rd', 'Known for pop music.'),  
('Music Publisher 4', '321 Melody St', 'Focuses on classical music.'),  
('Music Publisher 5', '654 Harmony Ln', 'Offers a variety of genres.'),  
('Music Publisher 6', '987 Rhythm Ct', 'Dedicated to emerging artists.');  

 
INSERT INTO album (titel, genre, date_creation, track_id, publisher_id) VALUES  
('Album 1', 'Pop', CURRENT_DATE, 1, 1),  
('Album 2', 'Rock', CURRENT_DATE, 1, 2),  
('Album 3', 'Jazz', CURRENT_DATE, 2, 3),  
('Album 4', 'Classical', CURRENT_DATE, 5, 4),  
('Album 5', 'Hip-Hop', CURRENT_DATE, 4, 5),  
('Album 6', 'Electronic', CURRENT_DATE, 3, 6);  

 
INSERT INTO orders (quantity, total_price, creation_date, user_id) VALUES  
(1, 1.99, CURRENT_DATE, 1),  
(2, 5.98, CURRENT_DATE, 2),  
(1, 3.99, CURRENT_DATE, 3),  
(3, 4.47, CURRENT_DATE, 4),  
(1, 2.49, CURRENT_DATE, 5),  
(2, 6.98, CURRENT_DATE, 6);  
  
INSERT INTO order_item (order_id, track_id) VALUES  
(1, 1),
(2, 2), 
(3, 3), 
(4, 4),  
(5, 5),  
(6, 6);  


INSERT INTO order_album (album_id, artist_id) VALUES  
(1, 1),  
(2, 2),  
(3, 3),  
(4, 4),  
(5, 5),  
(6, 6);
 
