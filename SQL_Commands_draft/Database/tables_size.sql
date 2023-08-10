SELECT
    relname AS table_name,
    pg_size_pretty(pg_total_relation_size(relid)) AS table_size
FROM
    pg_stat_all_tables
WHERE
    schemaname NOT LIKE 'pg_%'
ORDER BY
    pg_total_relation_size(relid) DESC;
