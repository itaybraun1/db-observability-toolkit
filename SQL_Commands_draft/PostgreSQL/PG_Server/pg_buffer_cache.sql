-- Number of buffers in each DB, also as a percentage from total. 
WITH total_num_of_buffers AS (
    SELECT count(*)  AS count_buffers
    FROM pg_buffercache
)
SELECT 
    d.datname AS db_name, 
    count(*) AS count_buffers,
    count(*) * 8 AS total_buffers_size_kb, 
    pg_size_pretty(count(*) * 8 * 1024) AS total_buffers_size,
    round((count(*)) * 100.0 / t.count_buffers, 2) AS percentage_of_total
FROM pg_buffercache b
INNER JOIN pg_database d ON b.reldatabase = d.oid
CROSS JOIN total_num_of_buffers t
GROUP BY d.datname, 
	t,count_buffers
ORDER BY d.datname;

-- A Query for the MMC
SELECT 
    d.datname AS db_name, 
    count(*) AS count_buffers,
    count(*) * 8 AS total_buffers_size
FROM pg_buffercache b
INNER JOIN pg_database d ON b.reldatabase = d.oid
GROUP BY d.datname
ORDER BY total_buffers_size DESC
LIMIT 100;