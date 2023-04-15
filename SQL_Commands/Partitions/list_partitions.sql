-- Shows the partitions of the paritioned tables only. 
/* This query retrieves the inheritance hierarchy of all tables in the database by querying the pg_inherits system catalog table. It selects the inhparent and inhrelid columns, which represent the parent table and child table respectively. The ::regclass cast is used to convert the oid values to their corresponding table names. The results are sorted by the parent table name and child table name using the ORDER BY clause.*/
SELECT pg_inherits.inhparent::regclass AS table_name, 
	pg_inherits.inhrelid::regclass AS partition_name
FROM pg_inherits
ORDER BY pg_inherits.inhparent, pg_inherits.inhrelid;

--Desc: all the table in the db 
SELECT nspname AS schema_name, relname AS table_name, * 
FROM pg_class
JOIN pg_namespace ON relnamespace = pg_namespace.oid
WHERE relkind in ('r', 'p')
AND relispartition = 'false'
AND nspname not in ('pg_catalog', 'information_schema')

ORDER BY 1, 2
LIMIT 1000;

--Desc: Tables that have partitions (parent tables) and the number of partitions
SELECT parent.oid, parent.relname AS table_name, parent.relkind, COUNT(*) AS num_child_tables
FROM pg_inherits
JOIN pg_class AS parent ON pg_inherits.inhparent = parent.oid
WHERE parent.relkind = 'p'
GROUP BY parent.oid,parent.relname,parent.relkind;

