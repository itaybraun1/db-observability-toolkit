-- https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STATIO-ALL-TABLES-VIEW
SELECT sum(heap_blks_hit)  / 
	sum(heap_blks_hit + heap_blks_read) AS cache_hit_ratio
FROM pg_statio_user_tables;
