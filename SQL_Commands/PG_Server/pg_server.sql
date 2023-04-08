-- Returnes the version of the PostgreSQL database server. For ex. PostgreSQL 13.7 on aarch64-unknown-linux-gnu, compiled by gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), 64-bit
SELECT version();
-- Returnes the version of the PostgreSQL server as x.y. For ex. 13.7
SELECT substring(version() from 'PostgreSQL ([0-9]+\.[0-9]+)');

-- Returns a list of databases and their size 
SELECT pg_database.datname AS database_name, 
pg_database_size(pg_database.datname) as size_kb, 
pg_size_pretty(pg_database_size(pg_database.datname)) AS size
FROM pg_database
ORDER BY pg_database.datname ASC;

