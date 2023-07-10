-- Database Size
SELECT 
	oid, 
  datname as database_name, 
  pg_database_size(datname) as database_size,
	pg_size_pretty(pg_database_size(datname))
FROM pg_database 
WHERE datistemplate = false;