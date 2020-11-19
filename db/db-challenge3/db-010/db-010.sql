SELECT chatrooms.name,
    users.diplay_name,
    posts.created_at
FROM posts
    LEFT JOIN users ON users.id = posts.created_user_id
    LEFT JOIN chatrooms ON chatrooms.id= posts.chatroom_id
WHERE (posts.chatroom_id, posts.created_at
) IN
(SELECT chatroom_id, MAX(posts.created_at) AS created_at
FROM posts
    LEFT JOIN users ON users.id = posts.created_user_id
WHERE users.is_deleted = 0
    AND posts.is_deleted = 0
GROUP BY chatroom_id)
ORDER BY chatrooms.id;