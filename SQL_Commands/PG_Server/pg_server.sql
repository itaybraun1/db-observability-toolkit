SELECT version();
SELECT substring(version() from 'PostgreSQL ([0-9]+\.[0-9]+)');

SELECT pg_database.datname AS database_name, pg_size_pretty(pg_database_size(pg_database.datname)) AS size
FROM pg_database
ORDER BY pg_database_size(pg_database.datname) DESC;
