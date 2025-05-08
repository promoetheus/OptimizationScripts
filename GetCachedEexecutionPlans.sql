SELECT d.object_id, d.database_id, OBJECT_NAME(object_id, database_id) 'proc name',   
    d.cached_time, d.last_execution_time, d.total_elapsed_time,  
    d.total_elapsed_time/d.execution_count AS [avg_elapsed_time_microseconds],  
    d.last_elapsed_time AS [last_elapsed_time_microseconds], d.execution_count  
FROM sys.dm_exec_procedure_stats AS d 
WHERE OBJECT_NAME(object_id, database_id) = 'GetCardData'
ORDER BY [total_worker_time] DESC;  
