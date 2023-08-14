/******* Troubleshotting PG cron **************/
--Resources: 
-- > https://github.com/citusdata/pg_cron
-- View existing cron jobs
SELECT * 
FROM cron.job;

-- To delete (un-schedule) a job by its ID. 
SELECT cron.unschedule(2);

--View Jobs execution
SELECT 
	jobid,
  runid,
  job_pid, 
  database, 
  username, 
  command, 
  status, /* Can be succeeded or failed */
  return_message, 
  start_time, 
  end_time, 
  EXTRACT(MILLISECONDS FROM (end_time - start_time)) AS difference_in_milliseconds

FROM cron.job_run_details
WHERE jobid = 3;


-- Installed Extensions
SELECT 
    e.extname AS "Name", 
    e.extversion AS "Version", 
    n.nspname AS "Schema", 
    c.description AS "Description" 
FROM pg_catalog.pg_extension e 
LEFT JOIN pg_catalog.pg_namespace n 
	ON n.oid = e.extnamespace 
LEFT JOIN pg_catalog.pg_description c 
	ON c.objoid = e.oid 
  AND c.classoid = 'pg_catalog.pg_extension'::pg_catalog.regclass 
ORDER BY 1;

-- The size of the Data Sets
SELECT 
	'metis.pg_stat_tables_activity_snapshots' as table_name,
	count(*) as rows, 
 	max(insert_date) as max_insert_date
FROM  metis.pg_stat_tables_activity_snapshots
UNION ALL
SELECT
	'pg_stat_database_snapshots' as table_name,
	count(*) as rows, 
 	max(insert_date) as max_insert_date
FROM  metis.pg_stat_database_snapshots