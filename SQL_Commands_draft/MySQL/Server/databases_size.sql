-- Calculate the size of each database by summing the Data_length and Index_length values for all tables belonging to that database. 
-- Remember that in MySQL the schema is the DB (unlike Postgres or MSSQL)
SELECT
    table_schema AS database_name,
    SUM(data_length + index_length) / 1024 / 1024 AS size_mb
FROM
    information_schema.tables
GROUP BY
    table_schema;