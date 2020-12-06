SELECT COUNT(posts.id) AS '投稿数',
    chatrooms.name AS 'チャットルーム名'
FROM posts
    JOIN chatrooms ON posts.chatroom_id = chatrooms.id
    JOIN users ON posts.created_user_id = users.id
WHERE users.is_deleted = 0
    AND posts.is_deleted = 0
GROUP BY chatrooms.name
ORDER BY '投稿数' DESC;