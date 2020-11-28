/* is_deleted = 1のuser_id かつ is_deleted = 1のchatroom_idのみ削除する命令文 */
BEGIN;
    SELECT *
    FROM chatroom_members
        LEFT JOIN chatrooms ON chatrooms.id=chatroom_members.chatroom_id
        LEFT JOIN users ON users.id=chatroom_members.user_id
    WHERE chatrooms.is_deleted = 1
        AND users.is_deleted=1;
    COMMIT;

/*
is_deleted = 1のuserのレコードを全て破棄する命令文
BEGIN;
    SET FOREIGN_KEY_CHECKS = 0;
    DELETE FROM chatroom_members
    WHERE user_id =(SELECT id FROM users WHERE is_deleted=1);
    SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
*/

/*
前回提出時の命令文
BEGIN;
    DELETE FROM chatroom_members
    WHERE chatroom_members.chatroom_id IN
        (SELECT chatrooms.id
        FROM (SELECT chatroom_members.chatroom_id, chatroom_members.user_id FROM chatroom_members)
            AS chatroom_members_alias --ERROR 1093回避のためのエイリアス
        JOIN chatrooms ON chatroom_members_alias.chatroom_id = chatrooms.id
        JOIN users ON chatroom_members_alias.user_id = users.id
        WHERE chatrooms.is_deleted = 1
        AND users.is_deleted = 1)
    AND chatroom_members.user_id IN
        (SELECT users.id
        FROM (SELECT chatroom_members.chatroom_id, chatroom_members.user_id FROM chatroom_members)
            AS chatroom_members_alias --ERROR 1093回避のためのエイリアス
        JOIN chatrooms ON chatroom_members_alias.chatroom_id = chatrooms.id
        JOIN users ON chatroom_members_alias.user_id = users.id
        WHERE chatrooms.is_deleted = 1
        AND users.is_deleted = 1);
COMMIT;
*/
