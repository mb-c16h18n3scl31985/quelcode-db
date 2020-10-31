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

CREATE TABLE chatrooms
(
    chatroom_id INTEGER PRIMARY KEY,
    chatroom_name VARCHAR(100) NOT NULL,
    description VARCHAR(1000),
    is_enabled_file_upload TINYINT(1) DEFAULT 1 NOT NULL,
    is_direct_chat TINYINT(1) DEFAULT 0 NOT NULL,
    is_deleted TINYINT(1) DEFAULT 0 NOT NULL,
    created_at DATETIME NOT NULL,
    created_user_id INTEGER REFERENCES users(user_id) NOT NULL,
    modified_at DATETIME NOT NULL,
    modified_user_id INTEGER REFERENCES users(user_id) NOT NULL
)