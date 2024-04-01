-- Cache hit ratio of every table
-- It has a CASE to avoid dividing by Zero. 
SELECT
	relid, 
  schemaname, 
  relname,
	heap_blks_read as heap_read,
  heap_blks_hit as heap_hit,
  CASE
  	WHEN heap_blks_hit + heap_blks_read = 0 THEN 0
    ELSE round(
      	heap_blks_hit / (heap_blks_hit + heap_blks_read)::numeric, 3) 
    END as ratio
FROM
  pg_statio_user_tables;