------- P A R T I T I O N S ------------------

-- Show the parent tables 
SELECT * 
FROM pg_class as c
	JOIN pg_namespace  as ns 
  	ON c.relnamespace = ns.oid 
WHERE 
 relkind = 'p'
AND nspname not in ('pg_catalog', 'information_schema')


-- Shows the partitions of the paritioned tables only. 
/* This query retrieves the inheritance hierarchy of all tables in the database by querying the pg_inherits system catalog table. It selects the inhparent and inhrelid columns, which represent the parent table and child table respectively. The ::regclass cast is used to convert the oid values to their corresponding table names. The results are sorted by the parent table name and child table name using the ORDER BY clause.*/
SELECT pg_inherits.inhparent::regclass AS table_name, 
	pg_inherits.inhrelid::regclass AS partition_name
FROM pg_inherits
ORDER BY pg_inherits.inhparent, pg_inherits.inhrelid;

-- Count How many partitions every table has (excluding indexes)
SELECT pg_inherits.inhparent::regclass AS table_name, 
	COUNT (pg_inherits) AS count_partitions
FROM pg_inherits 
	JOIN pg_class  
		ON pg_inherits.inhparent = pg_class.oid
WHERE pg_class.relkind in ('p') 
GROUP BY pg_inherits.inhparent::regclass;

-- Same Results, different query. 
--Desc: Tables that have partitions (parent tables) and the number of partitions
SELECT parent.oid, parent.relname AS table_name, parent.relkind, COUNT(*) AS num_child_tables
FROM pg_inherits
	JOIN pg_class AS parent 
		ON pg_inherits.inhparent = parent.oid
WHERE parent.relkind = 'p'
GROUP BY parent.oid,parent.relname,parent.relkind;

-- Shows the parent table name. Also shows every partition and its size (pages, rows)
SELECT 
  pg_inherits.inhparent::regclass AS table_name, 
	pg_inherits.inhrelid::regclass AS partition_name, 
  pg_class.oid,
  pg_class.relpages, 
  pg_class.reltuples
FROM pg_inherits
	JOIN pg_class
  	ON pg_inherits.inhrelid = pg_class.oid
ORDER BY pg_inherits.inhparent, pg_inherits.inhrelid;


-- Based on the query above, show the actual size of each table
-- Shows the parent table name. Also shows every partition and its size (pages, rows)
SELECT 
  pg_inherits.inhparent::regclass AS table_name, 
	COUNT(pg_inherits.inhrelid::regclass) AS partition_name, 
  SUM(pg_class.relpages) as total_pages, 
  SUM(pg_class.reltuples) as total_rows
FROM pg_inherits
	JOIN pg_class
  	ON pg_inherits.inhrelid = pg_class.oid
GROUP BY pg_inherits.inhparent::regclass



--Desc: all the table in the db 
SELECT nspname AS schema_name, relname AS table_name, * 
FROM pg_class
JOIN pg_namespace ON relnamespace = pg_namespace.oid
WHERE relkind in ('r', 'p')
AND relispartition = 'false'
AND nspname not in ('pg_catalog', 'information_schema')

ORDER BY 1, 2
LIMIT 1000;


-- Select all the tables without partitions

--     NOT FINISHED    ---
SELECT * 
FROM pg_class as c
	JOIN pg_namespace  as ns 
  	ON c.relnamespace = ns.oid 
WHERE c.oid not in (SELECT distinct inhparent from pg_inherits ) 
AND relkind = 'r'
AND nspname not in ('pg_catalog', 'information_schema')






