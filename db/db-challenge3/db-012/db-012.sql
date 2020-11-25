BEGIN;
    UPDATE chatrooms
    SET is_enabled_file_upload = 0, modified_at=NOW(), modified_user_id = 1
    WHERE chatrooms.id NOT IN
    (SELECT chatrooms_alias.id
        FROM (SELECT id FROM chatrooms)AS chatrooms_alias
        /*ERROR1093 回避のためのエイリアス*/
        JOIN chatroom_members ON chatrooms_alias.id = chatroom_members.chatroom_id
        WHERE chatroom_members.user_id=1)
    AND is_deleted = 0;
COMMIT;

/*
副問合せ用のメモ
SELECT chatrooms.id, chatrooms.name, chatroom_members.user_id
FROM chatrooms
    JOIN chatroom_members ON chatrooms.id=chatroom_members.chatroom_id
WHERE user_id=1;
*/