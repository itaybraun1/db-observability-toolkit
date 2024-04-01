-- index_usage:
-- Notice the query is not ordered by activity. 
SELECT
  sui.schemaname AS schema,
  sui.relid, 
  sui.relname AS table, 
  sui.indexrelid, 
  sui.indexrelname AS index, 
  sui.idx_scan AS index_scans, 
  sui.idx_tup_read AS index_rows_reads, 
  sui.idx_tup_fetch AS index_rows_writes,
  sio_ui.idx_blks_read AS pages_read_from_disk, 
  sio_ui.idx_blks_hit AS pages_read_from_buffer
FROM pg_stat_user_indexes AS sui
     JOIN pg_statio_user_indexes AS sio_ui
            ON sui.relid = sio_ui.relid
            AND sui.indexrelid = sio_ui.indexrelid
ORDER BY  
	sui.schemaname, 
	sui.relname,
  sui.indexrelname
LIMIT 5000;  
