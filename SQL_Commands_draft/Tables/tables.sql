/* Desc: The query returns a list of tables and their size */


/* Desc: shows the size of the tables and their indexes */
SELECT relid,
		schemaname, 
    relname as table_name, 
    (schemaname || '.' || relname) as full_table_name,
    n_live_tup as rows,
    n_dead_tup as dead_rows,
    n_mod_since_analyze,
    case 
    	when n_live_tup = 0 THEN 0
      else  n_mod_since_analyze / n_live_tup 
      end as pct_mod_since_analyze,
    last_analyze as last_analyze_date,
    last_autoanalyze as last_autoanalyze_date,
    pg_total_relation_size(relid) / 1024 as total_table_size_kb, 
    pg_table_size(relid) / 1024 as table_size_kb,
    pg_indexes_size(relid) / 1024 as indexes_size_kb,
    pg_size_pretty(pg_total_relation_size(relid)) as total_table_size_pretty, 
    pg_size_pretty(pg_table_size(relid)) as table_size_pretty,
    pg_size_pretty(pg_indexes_size(relid)) as index_size_pretty
    
FROM pg_stat_user_tables
ORDER BY schemaname, 
    relname

/*  Desc: Shows how many indexes each table has */
SELECT 
	pg_tables.schemaname,
	pg_tables.tablename, 
  count(*) as num_indexes
FROM pg_tables
LEFT JOIN pg_indexes 
	ON pg_tables.tablename = pg_indexes.tablename
WHERE pg_tables.schemaname not in( 'pg_catalog', 'information_schema')
GROUP BY pg_tables.schemaname, 
	pg_tables.tablename
 ORDER by 1, 2;

/* Desc: show the objects in the database; relkind 'r' = table, 'p' = parent partitioned table 
reloption can be: autovacuum_enabled=false*/
SELECT * 
FROM pg_class
where relkind in ('p', 'r');