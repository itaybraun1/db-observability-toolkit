
-- Current metrics of DB performance
-- Use the query to take scapshots and compare it to the previous one
-- Resources: https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-DATABASE-VIEW  
--    Changes in every PG Version: https://pgstats.dev/pg_stat_database 
/* Columns: 
blks_read: Number of disk blocks read in this database.
blks_hit: Number of times disk blocks were found already in the buffer cache, so that a read was not necessary (this only includes hits in the PostgreSQL buffer cache, not the operating system's file system cache).
cache_hit_ratio - percentage of blocks read from the buffer cache only vs the total number of buffers read (both disk and cache). Should be close to %99
*/
SELECT 
	datid as dbid, 
  datname as db_name, 
  numbackends, 
  xact_commit, 
  xact_rollback,
  blks_read, 
  blks_hit, 
  round(blks_hit / (blks_read + blks_hit)::numeric, 4) as cache_hit_ratio,
  tup_returned, 
  tup_fetched, 
  tup_inserted, 
  tup_updated, 
  tup_deleted, 
  temp_files,
  deadlocks
  
FROM pg_stat_database

