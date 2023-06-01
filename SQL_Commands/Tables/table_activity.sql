SELECT
  schemaname || '.' || relname AS table_name,
  seq_scan AS reads,
  seq_tup_read AS tuples_read,
  n_tup_ins AS inserts,
  n_tup_upd AS updates,
  n_tup_del AS deletes
FROM
  pg_stat_user_tables
ORDER BY
  seq_scan DESC;