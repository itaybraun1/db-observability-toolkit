--pg_stat_statement
SELECT d.datname,
	queryid, 
    query,
	calls, 
    total_exec_time,
    min_exec_time, 
    max_exec_time, 
    mean_exec_time, 
    stddev_exec_time,
    rows, 
    shared_blks_hit, 
    shared_blks_read,
    *
FROM pg_stat_statements as st
	join pg_database as d
    	on st.dbid = d.oid
WHERE datname NOT IN ('postgres', 'rdsadmin' ) 
AND query NOT IN ('BEGIN', 'COMMIT', 'SELECT $1' ) 
and datname = 'airbases'
ORDER BY total_exec_time desc, calls desc
LIMIT 5000;










