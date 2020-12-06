BEGIN;
    UPDATE chatrooms
        SET is_enabled_file_upload = 0, modified_at=NOW(),modified_user_id = 1
        WHERE chatrooms.id NOT IN 
        (SELECT DISTINCT chatroom_id
        FROM chatroom_members
        WHERE user_id = 1)
        AND is_deleted =0;
    COMMIT;

/*
ERROR1093回避のために試した命令文
    BEGIN;
        UPDATE chatrooms
        SET is_enabled_file_upload = 0, modified_at=NOW(), modified_user_id = 1
        WHERE chatrooms.id NOT IN
        (SELECT chatrooms.id
            FROM chatroom_members
                JOIN chatrooms ON chatrooms.id = chatroom_members.chatroom_id
            WHERE chatroom_members.user_id=1)
            AND is_deleted = 0;
    COMMIT;
実行結果
    #1093 - FROM句にある表 'chatrooms' はUPDATEの対象にできません。
*/

/*
前回提出した命令文
UPDATE chatrooms
    SET is_enabled_file_upload = 0, modified_at=NOW(), modified_user_id = 1
    WHERE chatrooms.id NOT IN
    (SELECT chatrooms_alias.id
    FROM (SELECT id
        FROM chatrooms)AS chatrooms_alias --ERROR1093 回避のためのエイリアス
        JOIN chatroom_members ON chatrooms_alias.id = chatroom_members.chatroom_id
    WHERE chatroom_members.user_id=1)
    AND is_deleted = 0;
*/