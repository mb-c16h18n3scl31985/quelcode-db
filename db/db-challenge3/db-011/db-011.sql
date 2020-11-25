BEGIN;
    UPDATE tasks
SET is_completed = 1, modified_at = NOW()
WHERE created_at BETWEEN '2020-04-26T00:00:00' AND '2020-04-26T11:30:00'
        AND is_deleted = 0
        AND created_user_id = 1;
    COMMIT;