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


/* Desc: This query returns how many days the PG server is up*/
SELECT date_trunc('second', current_timestamp - pg_postmaster_start_time()) as uptime;

--Configuration
--The view pg_settings provides access to run-time parameters of the server. It is essentially an alternative interface to the SHOW and SET commands. It also provides access to some facts about each parameter that are not directly available from SHOW, such as minimum and maximum values.
SELECT * FROM pg_settings
