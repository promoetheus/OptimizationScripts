SELECT cplan.usecounts, cplan.objtype, cplan.plan_handle, qtext.text, qplan.query_plan
FROM sys.dm_exec_cached_plans AS cplan WITH(NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS qtext
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qplan
WHERE qtext.text LIKE '%GetCardData%'
	and cplan.objtype = 'Proc'
ORDER BY cplan.usecounts DESC
