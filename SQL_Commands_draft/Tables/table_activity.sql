
/***********************
Resources: 
- The table https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ALL-TABLES-VIEW
-- HOT update: https://www.postgresql.org/docs/current/storage-hot.html 
To help reduce the overhead of updates, PostgreSQL has an optimization called heap-only tuples (HOT). This optimization is possible when:
  * The update does not modify any columns referenced by the table's indexes, including expression and partial indexes.
  * There is sufficient free space on the page containing the old row for the updated row
In such cases, heap-only tuples provide two optimizations:
  * New index entries are not needed to represent updated rows.
  * Old versions of updated rows can be completely removed during normal operation, including SELECTs, instead of requiring periodic vacuum operations. (This is possible because indexes do not reference their page item identifiers.)
*/
SELECT 
  relid, 
  schemaname, 
  relname, 
  seq_scan, 
  seq_tup_read,
  idx_scan, 
  idx_tup_fetch, 
  n_tup_ins, 
  n_tup_upd, 
  n_tup_del, 
  n_tup_hot_upd, 
  n_dead_tup, 
  n_live_tup,
  n_mod_since_analyze, 
  n_ins_since_vacuum, 
  last_vacuum, 
  last_autovacuum, 
  last_analyze, 
  last_autoanalyze, 
  vacuum_count, 
  autovacuum_count, 
  autoanalyze_count
FROM pg_stat_user_tables;


