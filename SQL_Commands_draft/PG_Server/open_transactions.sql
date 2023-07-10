--longest_running_active_queries
--This view is intended to be typically used by administrators in determining which queries to focus on. However it can be used for reporting and alerting as well.
-- Filter only command run more than 5 min
SELECT 
		pg_stat_activity.application_name,
    pg_stat_activity.state,
    pg_stat_activity.wait_event_type,
    pg_stat_activity.wait_event,
    pg_stat_activity.query,
    pg_stat_activity.pid,
    pg_stat_activity.client_addr,
    age(now(), pg_stat_activity.query_start) AS running_time
FROM pg_stat_activity
WHERE (pg_stat_activity.state = 'active'::text) 
	AND pg_stat_activity.pid <> pg_backend_pid()
  AND (now() - pg_stat_activity.query_start) > interval '5 minutes'
ORDER BY running_time DESC; 





