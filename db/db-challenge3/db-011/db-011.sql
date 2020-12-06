BEGIN;
    UPDATE tasks
    SET is_completed = 1, modified_at = NOW(),modified_user_id=1
    WHERE created_at BETWEEN '2020-04-26T09:00:00' AND '2020-04-26T11:30:00'
        AND is_deleted = 0;
    COMMIT;