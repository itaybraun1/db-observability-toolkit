https://www.crunchydata.com/blog/data-skews-in-postgres
SELECT starelid::regclass AS table_name,
attname AS column_name,
(SELECT string_agg('',format(E'\'%s\': %s%%\n', v,ROUND(n::numeric*100, 2)))
	FROM 
 	unnest(stanumbers1,stavalues1::text::text[])nvs(n,v)
	) as pcts   -- This is a column
FROM pg_statistic
	JOIN pg_attribute 
  	ON attrelid=starelid
		AND attnum = staattnum
	JOIN pg_class 
		ON attrelid = pg_class.oid
	JOIN pg_namespace 
		ON pg_class.relnamespace = pg_namespace.oid
WHERE nspname NOT LIKE 'pg_%' 
	AND nspname <> 'information_schema'
    AND stanumbers1[1] >= .3  -- Where one value is at least 30% of the data