/* Query Desc: Returns the configuration property of the max number of connections */
SELECT 'configured_max_connection' as metric_name, 
	setting as value, 
  short_desc
 FROM pg_settings 
 WHERE name = 'max_connections'
 
	Union all 
SELECT 
	'active_connections' as metric_name,
  COUNT(*)::text as value,
  'Active connections' as short_desc
FROM pg_stat_activity  
WHERE pid <> pg_backend_pid() 
AND state = 'active'

	Union all 
SELECT 
	'idle_connections' as metric_name,
  COUNT(*)::text as value,
  'Idle connections' as short_desc
FROM pg_stat_activity  
WHERE pid <> pg_backend_pid() 
AND state in ('idle in transaction', 'idle')


-- Connections, idle and non idle
SELECT * 
FROM ( 
select 
	count(1) as total_connections, 
  sum(case when state!='idle' then 1 else 0 end) as non_idle_connections, 
  sum(case when state='idle' then 1 else 0 end) as idle_connections, 
  round( sum(case when state='idle' then 1 else 0 end)::numeric / count(1), 2) as idle_connections_pct
from pg_stat_activity
) AS t1
CROSS JOIN   
	 (select setting as max_connections 
    from pg_settings 
    where name='max_connections') as s

 -- Connections per DATABASE
    