CREATE TABLE users
(
    id INTEGER(11) PRIMARY KEY AUTO_INCREMENT,
    mail VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    profile VARCHAR(1000),
    is_deleted TINYINT(1) DEFAULT 0, -- 1:削除済み
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at DATETIME ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    office_phone VARCHAR(13),
    mobile_phone VARCHAR(13)
);

CREATE TABLE chatrooms
(
    id INTEGER(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(1000),
    is_enabled_file_upload TINYINT(1) DEFAULT 1 NOT NULL, -- 1:ファイルアップロード可能
    is_direct_chat TINYINT(1) DEFAULT 0 NOT NULL, --  1:ダイレクトチャット
    is_deleted TINYINT(1) DEFAULT 0 NOT NULL, -- 1:削除済み
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_user_id INTEGER(11) NOT NULL,
    modified_at DATETIME ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    modified_user_id INTEGER(11)  NOT NULL,
    FOREIGN KEY chatroom_id REFERENCES chatrooms(id),
    FOREIGN KEY user_id REFERENCES users(id),
);

CREATE TABLE chatroom_members
(
    chatroom_id INTEGER(11) NOT NULL,
    user_id INTEGER(11) NOT NULL,
    joined_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(chatroom_id,user_id),
    FOREIGN KEY chatroom_id REFERENCES chatrooms(id),
    FOREIGN KEY user_id REFERENCES users(id)
);

CREATE TABLE posts
(
    id INTEGER(11) PRIMARY KEY AUTO_INCREMENT,
    chatroom_id INTEGER(11) NOT NULL,
    content VARCHAR(1000) NOT NULL,
    attachment_name VARCHAR(100),
    is_deleted TINYINT(1) DEFAULT 0 NOT NULL, -- 1:削除済み
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_user_id INTEGER(11) NOT NULL,
    modified_at DATETIME ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    modified_user_id INTEGER(11) NOT NULL,
    FOREIGN KEY chatroom_id REFERENCES chatrooms(id),
    FOREIGN KEY created_user_id REFERENCES users(id),
    FOREIGN KEY modified_user_id REFERENCES users(id)
);

CREATE TABLE tasks
(
    id INTEGER(11) PRIMARY KEY AUTO_INCREMENT,
    chatroom_id INTEGER(11),
    content VARCHAR(1000) NOT NULL,
    responsible_user_id INTEGER NOT NULL,
    limited_at DATETIME,
    is_completed TINYINT(1) DEFAULT 0 NOT NULL, -- 1:完了
    is_deleted TINYINT(1) DEFAULT 0 NOT NULL, -- 1:削除済み
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_user_id INTEGER(11)  NOT NULL,
    modified_at DATETIME ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    modified_user_id INTEGER(11) NOT NULL,
    FOREIGN KEY chatroom_id REFERENCES chatrooms(id),
    FOREIGN KEY respomsible_user_id REFERENCES users(id),
    FOREIGN KEY created_user_id REFERENCES users(id),
    FOREIGN KEY modified_user_id REFERENCES users(id)
);