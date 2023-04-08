-- Shows the partitions of the paritioned tables only. 
/* This query retrieves the inheritance hierarchy of all tables in the database by querying the pg_inherits system catalog table. It selects the inhparent and inhrelid columns, which represent the parent table and child table respectively. The ::regclass cast is used to convert the oid values to their corresponding table names. The results are sorted by the parent table name and child table name using the ORDER BY clause.*/
SELECT pg_inherits.inhparent::regclass AS table_name, 
	pg_inherits.inhrelid::regclass AS partition_name
FROM pg_inherits
ORDER BY pg_inherits.inhparent, pg_inherits.inhrelid;

