-- Current metrics of DB performance
-- Use the query to take scapshots and compare it to the previous one

SELECT 
	datid as dbid, 
  datname as db_name, 
  numbackends, 
  xact_commit, 
  xact_rollback,
  blks_read, 
  blks_hit,
  tup_returned, 
  tup_fetched, 
  tup_inserted, 
  tup_updated, 
  tup_deleted, 
  temp_files,
  deadlocks
FROM pg_stat_database

