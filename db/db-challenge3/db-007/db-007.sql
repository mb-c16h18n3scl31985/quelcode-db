SELECT id, name, description,
    CASE is_enabled_file_upload WHEN 0 THEN '許可'
                                WHEN 1 THEN '禁止'
    END AS ファイルアップロード,
    is_direct_chat, is_deleted, created_at, created_user_id, modified_at, modified_user_id
FROM chatrooms
WHERE is_deleted = 0
    AND description LIKE '%ダイレクトチャット'
ORDER BY id;
