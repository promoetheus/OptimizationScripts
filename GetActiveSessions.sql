SELECT
    r.session_id,
    r.request_id,
    r.status,
    r.command,
    r.start_time,
    r.cpu_time,
    r.total_elapsed_time,
    r.reads,
    r.writes,
    r.logical_reads,
    r.wait_type,
    r.wait_time,
    r.last_wait_type,
    r.blocking_session_id,
    s.login_name,
    s.host_name,
    s.program_name,
    s.status AS session_status,
    c.client_net_address,
    t.text AS sql_text,
    qp.query_plan
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s
    ON r.session_id = s.session_id
LEFT JOIN sys.dm_exec_connections c
    ON r.session_id = c.session_id
OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) t
OUTER APPLY sys.dm_exec_query_plan(r.plan_handle) qp
WHERE r.session_id <> @@SPID -- exclude current session
ORDER BY r.cpu_time DESC;
