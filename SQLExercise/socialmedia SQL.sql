CREATE DATABASE SocialMediaApp;
USE SocialMediaApp;

CREATE TABLE tUser (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    date_of_birth DATE,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

CREATE TABLE tFriends (
    friendship_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    friend_id INT,
    status ENUM('pending', 'accepted', 'blocked'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES tUser(user_id),
    FOREIGN KEY (friend_id) REFERENCES tUser(user_id)
);

CREATE TABLE tPosts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    content TEXT NOT NULL,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    likes_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES tUser(user_id)
);

CREATE TABLE tComments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES tPosts(post_id),
    FOREIGN KEY (user_id) REFERENCES tUser(user_id)
);

-- Updated user data
INSERT INTO tUser (username, email, password_hash, full_name, date_of_birth, phone, last_login)
VALUES
('ujitha', 'ujitha@gmail.com', 'pass123', 'Ujitha Reddy', '2003-07-15', '9876543210', NOW()),
('manasa', 'manasa@gmail.com', 'pass234', 'Manasa Devi', '2002-09-10', '9876500011', NOW()),
('archana', 'archana@gmail.com', 'pass345', 'Archana Kumari', '2001-11-25', '9876522233', NOW()),
('haripriya', 'haripriya@gmail.com', 'pass456', 'Haripriya Nair', '2003-04-19', '9876599999', NOW()),
('padma', 'padma@gmail.com', 'pass567', 'Padma Rao', '2002-05-09', '9876512345', NOW()),
('gayathri', 'gayathri@gmail.com', 'pass678', 'Gayathri Iyer', '2004-02-12', '9876534567', NOW());

-- Friend relationships
INSERT INTO tFriends (user_id, friend_id, status)
VALUES
(1, 2, 'accepted'),
(1, 3, 'accepted'),
(2, 3, 'pending'),
(3, 4, 'accepted'),
(4, 5, 'blocked'),
(5, 6, 'accepted'),
(6, 1, 'accepted');

-- Updated posts
INSERT INTO tPosts (user_id, content, image_url, likes_count)
VALUES
(1, 'Exploring new places while travelling!', NULL, 15),
(2, 'Visited ancient temples today 🛕', 'temple1.jpg', 9),
(3, 'Had an amazing party with friends 🎉', NULL, 22),
(4, 'Fun day out at the beach 😎', 'fun_day.png', 11),
(5, 'Being a true foodie today 🍜', NULL, 8),
(6, 'Another travelling adventure begins 🌍', 'travel2.jpg', 18);

-- Comments
INSERT INTO tComments (post_id, user_id, comment_text)
VALUES
(1, 2, 'That’s awesome, Ujitha!'),
(1, 3, 'Keep it up!'),
(2, 1, 'Beautiful temple, Manasa!'),
(3, 4, 'Looks like fun, Archana!'),
(4, 5, 'So cool, Haripriya!'),
(5, 6, 'Yummy!'),
(6, 1, 'Safe travels, Gayathri!');

-- Example queries

SELECT * 
FROM tUser
WHERE username = 'ujitha';

SELECT 
    p.post_id, 
    u.username, 
    p.content, 
    p.image_url, 
    p.created_at, 
    p.likes_count
FROM tPosts p
JOIN tUser u ON p.user_id = u.user_id
WHERE u.username = 'ujitha'
ORDER BY p.created_at DESC;

SELECT 
    f.friendship_id,
    u.username AS user_name,
    u2.username AS friend_name,
    f.status,
    f.created_at
FROM tFriends f
JOIN tUser u ON f.user_id = u.user_id
JOIN tUser u2 ON f.friend_id = u2.user_id
WHERE u.username = 'ujitha' AND f.status = 'accepted';

SELECT 
    u.user_id,
    u.username,
    u.full_name
FROM tUser u
WHERE u.user_id NOT IN (
    SELECT DISTINCT p.user_id
    FROM tPosts p
    WHERE p.created_at >= NOW() - INTERVAL 30 DAY
);

SELECT 
    ROUND(COUNT(p.post_id) / COUNT(DISTINCT u.user_id), 2) AS avg_posts_per_user
FROM tUser u
LEFT JOIN tPosts p ON u.user_id = p.user_id;

SELECT 
    u.username,
    COUNT(f.friend_id) AS total_friends
FROM tUser u
JOIN tFriends f ON u.user_id = f.user_id
WHERE f.status = 'accepted'
GROUP BY u.user_id, u.username
ORDER BY total_friends DESC
LIMIT 5;

SELECT 
    c.comment_id,
    u.username,
    u.full_name,
    c.comment_text,
    c.created_at
FROM tComments c
JOIN tUser u ON c.user_id = u.user_id
WHERE c.post_id = 1
ORDER BY c.created_at ASC;

SELECT 
    u.username AS mutual_friend
FROM tFriends f1
JOIN tFriends f2 ON f1.friend_id = f2.friend_id
JOIN tUser u ON f1.friend_id = u.user_id
WHERE f1.user_id = (SELECT user_id FROM tUser WHERE username = 'ujitha')
  AND f2.user_id = (SELECT user_id FROM tUser WHERE username = 'archana')
  AND f1.status = 'accepted'
  AND f2.status = 'accepted';

-- Delete old posts
DELETE FROM tPosts
WHERE created_at < NOW() - INTERVAL 1 YEAR;
