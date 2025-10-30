CREATE TABLE USERS (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    is_email_verified BOOLEAN DEFAULT FALSE,
    created_at DATE DEFAULT CURRENT_TIMESTAMP,
    updated_at DATE DEFAULT CURRENT_TIMESTAMP 
);

ALTER TABLE USERS DROP COLUMN username;
ALTER TABLE USERS DROP COLUMN full_name;

SELECT * FROM USERS;


INSERT INTO USERS (email, username, password_hash, full_name, is_email_verified) VALUES
('anggi@email.com', 'anggi123', '$2b$10$dXE8flr8wtv4b/C59Jk39O0unjs5EeGZHmYq85ETd2Y5al8aL7PAW', 'Anggi Prayoga', TRUE),
('ari@email.com', 'ari456', '$2b$10$iUUocTtBfsrzWWOlOl58qufrZNULRl/UzAtdTLGJVAG3gGn5XzQSy', 'Ari Eka Saputra', FALSE),
('hasan@email.com', 'hasan789', '$2b$10$QXD7iMxxa2OYeDSDzk4NZu3Y3KbsevTZas4XvEI0lD86VBZXDQ/xa', 'Maulana Hasan', TRUE);

CREATE TABLE EMAIL_VERIFICATION_TOKENS (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    is_used BOOLEAN DEFAULT FALSE,
    created_at DATE DEFAULT CURRENT_TIMESTAMP,
    used_at DATE NULL,
    
    FOREIGN KEY (user_id) REFERENCES USERS(id) ON DELETE CASCADE
);

CREATE TABLE PASSWORD_RESET_TOKENS (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    is_used BOOLEAN DEFAULT FALSE,
    created_at DATE DEFAULT CURRENT_TIMESTAMP,
    used_at DATE NULL,
    
    FOREIGN KEY (user_id) REFERENCES USERS(id) ON DELETE CASCADE
);

CREATE TABLE LOGIN_SESSIONS (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    session_token VARCHAR(255) NOT NULL UNIQUE,
    refresh_token VARCHAR(255) NOT NULL,
    created_at DATE DEFAULT CURRENT_TIMESTAMP,
    last_activity DATE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES USERS(id) ON DELETE CASCADE
);

CREATE TABLE LOGIN_ATTEMPTS (
    id SERIAL PRIMARY KEY,
    user_id INT NULL,
    email_or_username VARCHAR(255) NOT NULL,
    is_successful BOOLEAN NOT NULL,
    attempted_at DATE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES USERS(id) ON DELETE SET NULL
);

CREATE TABLE PROFILE (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25),
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,

    FOREIGN KEY (user_id) REFERENCES USERS(id) ON DELETE CASCADE
);


INSERT INTO EMAIL_VERIFICATION_TOKENS (user_id, token) VALUES
(2, 'token_verifikasi_email_ari_123456789');

INSERT INTO PASSWORD_RESET_TOKENS (user_id, token) VALUES
(1, 'token_reset_password_anggi_987654321');

INSERT INTO LOGIN_SESSIONS (user_id, session_token, refresh_token) VALUES
(1, 'session_token_anggi_abc123', 'refresh_token_anggi_xyz789'),
(3, 'session_token_hasan_def456', 'refresh_token_hasan_uvw012');

INSERT INTO LOGIN_ATTEMPTS (user_id, email_or_username, is_successful) VALUES
(1, 'anggi123', TRUE),
(NULL, 'userpalsu', FALSE),
(2, 'ari456', TRUE),
(NULL, 'ari@email.com', FALSE);

SELECT * FROM USERS;

SELECT * FROM USERS WHERE is_email_verified = TRUE;

SELECT * FROM EMAIL_VERIFICATION_TOKENS WHERE is_used = FALSE;

SELECT * FROM LOGIN_SESSIONS;

SELECT la.id, u.username, la.email_or_username, la.is_successful, la.attempted_at
FROM LOGIN_ATTEMPTS AS la
LEFT JOIN USERS AS u ON la.user_id = u.id;