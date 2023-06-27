--Table Space Size

SELECT 
	pg_tablespace.spcname AS name,
    pg_tablespace_size(pg_tablespace.oid) AS bytes,
    pg_size_pretty(pg_tablespace_size(pg_tablespace.oid)) AS size
FROM pg_tablespace;