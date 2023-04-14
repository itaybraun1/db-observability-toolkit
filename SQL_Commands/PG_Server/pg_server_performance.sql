-- https://user3141592.medium.com/postgres-performance-scripts-99428f6b56d9#:~:text=The%20pg_stat_statments%20table%20holds%20information,for%20each%20query%20that%20ran
/* Desc: Shows the 10 slowest queries with over a 1000 calls */
SELECT query, 
    total_exec_time,
    calls, 
    rows,
    calls, (total_exec_time/calls)::integer AS avg_time_ms 
FROM pg_stat_statements
WHERE calls > 1000
ORDER BY avg_time_ms DESC
LIMIT 10;