BEGIN;
    DELETE FROM chatroom_members
    WHERE chatroom_members.chatroom_id IN
        (SELECT chatrooms.id
        FROM (SELECT chatroom_members.chatroom_id, chatroom_members.user_id FROM chatroom_members)
            AS chatroom_members_alias
            /*ERROR 1093回避のためのエイリアス*/
        JOIN chatrooms ON chatroom_members_alias.chatroom_id = chatrooms.id
        JOIN users ON chatroom_members_alias.user_id = users.id
        WHERE chatrooms.is_deleted = 1
        AND users.is_deleted = 1)
    AND chatroom_members.user_id IN
        (SELECT users.id
        FROM (SELECT chatroom_members.chatroom_id, chatroom_members.user_id FROM chatroom_members)
            AS chatroom_members_alias
            /*ERROR 1093回避のためのエイリアス*/
        JOIN chatrooms ON chatroom_members_alias.chatroom_id = chatrooms.id
        JOIN users ON chatroom_members_alias.user_id = users.id
        WHERE chatrooms.is_deleted = 1
        AND users.is_deleted = 1);
COMMIT;

/*
副問合せ用のメモ
SELECT chatrooms.id
FROM chatroom_members
    JOIN chatrooms ON chatroom_members.chatroom_id =chatrooms.id
    JOIN users ON chatroom_members.user_id = users.id
WHERE chatrooms.is_deleted=1
    AND users.is_deleted=1;
*/