SELECT
    relname AS table_name,
   /*
relid: The OID (Object Identifier) of the table.
schemaname: The schema name of the table.
relname: The name of the table.
seq_scan: The number of sequential scans initiated on the table.

seq_tup_read: The number of tuples read by sequential scans.

idx_scan: The number of index scans initiated on the table.

idx_tup_fetch: The number of tuples fetched by index scans.

n_tup_ins: The number of tuples inserted into the table.

n_tup_upd: The number of tuples updated in the table.

n_tup_del: The number of tuples deleted from the table.

n_tup_hot_upd: The number of "hot" tuples updated in the table.

n_live_tup: The estimated number of live tuples in the table.

n_dead_tup: The estimated number of dead tuples in the table.

n_mod_since_analyze: The number of tuples modified since the last analyze operation.

last_vacuum: The timestamp of the last vacuum operation on the table.

last_autovacuum: The timestamp of the last automatic vacuum operation on the table.

last_analyze: The timestamp of the last analyze operation on the table.

last_autoanalyze: The timestamp of the last automatic analyze operation on the table.

vacuum_count: The number of times the table has been manually vacuumed.

autovacuum_count: The number of times the table has been automatically vacuumed.

analyze_count: The number of times the table has been manually analyzed.

autoanalyze_count: The number of times the table has been automatically analyzed.

Please note that these statistics are reset when the PostgreSQL server restarts or when the ANALYZE command is run on the table. Also, the view pg_stat_user_tables shows statistics for tables that are accessible to the currently logged-in user. If you need information about system-wide statistics, you might want to use the pg_stat_all_tables view.


*/

SELECT 
  relid, 
  schemaname, 
  relname as table_name, 
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
  pg_total_relation_size(relid)/1024 AS table_size
FROM pg_stat_user_tables



-- Table size. Without the usage of pg_stat_statements
select relname as table_name,
	pg_table_size(oid) as table_size
from pg_class
WHERE relkind = 'r'

