SELECT
    s.session_id,
    r.status,
    r.command,
    r.database_id,
    tsk.exec_context_id,
    tsk.task_alloc,
    tsk.task_dealloc,
    s.login_name,
    s.host_name,
    s.program_name
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
JOIN (
    SELECT
        session_id,
        request_id,
        SUM(internal_objects_alloc_page_count + user_objects_alloc_page_count) * 8 AS task_alloc,
        SUM(internal_objects_dealloc_page_count + user_objects_dealloc_page_count) * 8 AS task_dealloc
    FROM sys.dm_db_task_space_usage
    GROUP BY session_id, request_id
) tsk ON r.session_id = tsk.session_id AND r.request_id = tsk.request_id
ORDER BY task_alloc DESC;
