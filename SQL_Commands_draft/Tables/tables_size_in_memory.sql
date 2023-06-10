/* Desc - A query to show the size of each table in memory */
SELECT
    relname AS table_name,
    pg_total_relation_size(relid) as table_size,
    pg_size_pretty(pg_total_relation_size(relid)) AS table_size_pretty
FROM
    pg_stat_all_tables
WHERE
    schemaname NOT LIKE 'pg_%'
ORDER BY
    pg_total_relation_size(relid) DESC;

SELECT
    sum(pg_total_relation_size(relid)) as table_size
FROM
    pg_stat_all_tables
WHERE
    schemaname NOT LIKE 'pg_%'  ;  