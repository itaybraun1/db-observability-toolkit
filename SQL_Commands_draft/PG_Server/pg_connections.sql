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

