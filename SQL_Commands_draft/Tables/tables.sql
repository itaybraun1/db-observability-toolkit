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

/* Desc: table size includiing TOAST */
-- The extracted name of the schema and table MUST be "schema" and "table", respectively.
-- table-size
SELECT 
	n.nspname AS schema,
    c.oid as table_oid,
    c.relname AS table, 
    relpages AS pages, 
    reltuples AS rows,
    sat.n_live_tup,
    sat.n_dead_tup,
    pg_relation_size(c.oid) / 1024 AS relation_size, 
    pg_table_size(c.oid) / 1024 AS table_size, 
    pg_indexes_size(c.oid) / 1024 AS indexes_size, 
    (pg_total_relation_size(c.oid) - pg_relation_size(c.oid) - pg_indexes_size(c.oid)) / 1024 AS toast_size
FROM pg_class AS c
    LEFT JOIN pg_namespace AS n
        ON (N.oid = c.relnamespace)
    JOIN pg_stat_all_tables as sat
 		ON sat.relid = c.oid
 WHERE relkind='r'
    AND n.nspname NOT IN ('pg_catalog', 'information_schema') 
ORDER BY 1, 2;
 

-- Another version of Table Size, requires editing. Can be deleted when no longer needed. 
SELECT 
	current_database() as database,
    n.nspname AS schema, 
    c.relname AS table, 
    n.nspname || '.' || c.relname as full_table_name,
    pg_size_pretty(pg_table_size(n.nspname || '.' || c.relname)),
    relpages AS pages, 
    reltuples AS rows,
    pg_relation_size(c.oid) / 1024 AS relation_size_kb,
    
    pg_table_size(c.oid) / 1024 AS table_size_kb, 
    pg_indexes_size(c.oid) / 1024 AS indexes_size_kb, 
    (pg_total_relation_size(c.oid) - pg_relation_size(c.oid) - pg_indexes_size(c.oid)) / 1024 AS toast_size_kb
FROM pg_class AS c
                  LEFT JOIN pg_namespace AS n
                        ON (N.oid = c.relnamespace)
WHERE relkind='r'
            AND n.nspname NOT IN ('pg_catalog', 'information_schema') 
ORDER BY 1, 2;


select  pg_size_pretty(pg_table_size('postgres_air.booking'))
