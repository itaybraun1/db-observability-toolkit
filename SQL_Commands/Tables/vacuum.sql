-- Active: 1652304203939@@3.69.95.41@5432
/* Desc: This query returns the configuration of autovacuum */
SELECT * 
from pg_settings 
where category like 'Autovacuum';

SELECT * 
FROM pg_class
where relkind in ('p', 'r')
and reloptions is not null