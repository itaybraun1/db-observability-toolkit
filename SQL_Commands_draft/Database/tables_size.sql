SELECT
    relname AS table_name,
    pg_size_pretty(pg_total_relation_size(relid)) AS table_size
FROM
    pg_stat_all_tables
WHERE
    schemaname NOT LIKE 'pg_%'
ORDER BY
    pg_total_relation_size(relid) DESC;

-- Table size. Without the usage of pg_stat_statements
select relname as table_name,
	pg_table_size(oid) as table_size
from pg_class
WHERE relkind = 'r'

