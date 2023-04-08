-- Returns a list of tables and their size 

SELECT table_schema, table_name, pg_size_pretty(pg_total_relation_size(table_schema || '.' || table_name)) AS size
FROM information_schema.tables
--WHERE table_schema = 'your_schema_name'
ORDER BY pg_total_relation_size(table_schema || '.' || table_name) DESC;
