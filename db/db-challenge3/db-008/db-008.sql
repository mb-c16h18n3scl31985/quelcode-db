SELECT users.display_name AS '参加しているユーザー名',
    chatrooms.name AS '参加しているチャットルーム名',
    CAST(chatroom_members.joined_at AS DATE) AS '参加日時'
FROM chatroom_members
    JOIN users ON chatroom_members.user_id= users.id
    JOIN chatrooms ON chatroom_members.chatroom_id = chatrooms.id
WHERE users.is_deleted = 0
    AND chatrooms.is_deleted=0
ORDER BY joined_at DESC;
