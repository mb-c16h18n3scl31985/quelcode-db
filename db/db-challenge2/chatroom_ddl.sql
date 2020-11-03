CREATE TABLE users
(
    id INTEGER(11) PRIMARY KEY AUTO_INCREMENT,
    mail VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    display_name VARCHAR(100)  NOT NULL,
    profile VARCHAR(1000),
    is_deleted TINYINT(1) DEFAULT 0, -- 1:削除済み
    created_at DATETIME,
    modified_t DATETIME,
    office_phone VARCHAR(13),
    mobile_phone VARCHAR(13)
);

CREATE TABLE chatrooms
(
    chatroom_id INTEGER(11) PRIMARY KEY AUTO_INCREMENT,
    chatroom_name VARCHAR(100) NOT NULL,
    description VARCHAR(1000),
    is_enabled_file_upload TINYINT(1) DEFAULT 1 NOT NULL, -- 1:ファイルアップロード可能
    is_direct_chat TINYINT(1) DEFAULT 0 NOT NULL, --  1:ダイレクトチャット
    is_deleted TINYINT(1) DEFAULT 0 NOT NULL, -- 1:削除済み
    created_at DATETIME NOT NULL,
    created_user_id INTEGER(11) REFERENCES users(user_id) NOT NULL,
    modified_at DATETIME NOT NULL,
    modified_user_id INTEGER(11) REFERENCES users(user_id) NOT NULL
);

CREATE TABLE chatroom_members
(
    chatroom_id INTEGER(11) REFERENCES chatrooms(chatroom_id) NOT NULL,
    user_id INTEGER(11) REFERENCES users(user_id) NOT NULL,
    joined_at TIMESTAMP NOT NULL,
    PRIMARY KEY(chatroom_id,user_id)
);

CREATE TABLE posts
(
    post_id INTEGER(11) PRIMARY KEY AUTO_INCREMENT,
    chatroom_id INTEGER(11) REFERENCES chatrooms(chatroom_id),
    content VARCHAR(1000) NOT NULL,
    attachment_name VARCHAR(100),
    is_deleted TINYINT(1) DEFAULT 0 NOT NULL, -- 1:削除済み
    created_at DATETIME NOT NULL,
    created_user_id INTEGER(11) REFERENCES users(user_id) NOT NULL,
    modified_at DATETIME NOT NULL,
    modified_user_id INTEGER(11) REFERENCES users(user_id) NOT NULL
);

CREATE TABLE tasks
(
    task_id INTEGER(11) PRIMARY KEY AUTO_INCREMENT,
    chatroom_id INTEGER(11) REFERENCES chatrooms(chatroom_id),
    content VARCHAR(1000) NOT NULL,
    user_id_in_charge INTEGER REFERENCES users(user_id) NOT NULL,
    limit_date_and_time TIMESTAMP,
    is_completed TINYINT(1) DEFAULT 0 NOT NULL, -- 1:完了
    is_deleted TINYINT(1) DEFAULT 0 NOT NULL, -- 1:削除済み
    created_at DATETIME NOT NULL,
    created_user_id INTEGER(11) REFERENCES users(user_id) NOT NULL,
    modified_at DATETIME NOT NULL,
    modified_user_id INTEGER(11) REFERENCES users(user_id) NOT NULL,
);