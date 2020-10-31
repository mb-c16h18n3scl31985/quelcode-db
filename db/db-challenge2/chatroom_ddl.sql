CREATE TABLE users
(
    user_id INTEGER PRIMARY KEY,
    mail VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    display_name VARCHAR(100),
    profile VARCHAR(1000),
    created_at DATETIME,
    modified_t DATETIME,
    is_deleted TINYINT(1) DEFAULT 0,
    office_phone CHAR(13),
    mobile_phone CHAR(13)
);