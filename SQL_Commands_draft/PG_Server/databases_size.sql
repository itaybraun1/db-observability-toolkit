-- Database Size
SELECT 
	oid as db_id, 
  datname as database_name, 
  pg_database_size(datname) / 1024 as database_size_kb,
	pg_size_pretty(pg_database_size(datname)) as db_size
FROM pg_database 
WHERE datistemplate = false;