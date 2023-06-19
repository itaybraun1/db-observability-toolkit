/* Index size
https://pgxn.org/dist/pgtelemetry/doc/pgtelemetry.html
*/

SELECT c.oid
,
    
(c.oid)::regclass AS index
,
    pg_relation_size
(
     (c.oid)::regclass
) AS bytes
,
    pg_size_pretty
(pg_relation_size
     (
           (c.oid)::regclass
     )
) AS size
   
FROM (pg_class c
     
  JOIN pg_namespace n 
    ON (
           (c.relnamespace = n.oid)
     )
)
  
WHERE (
     (c.relkind = 'i'::"char")
   AND (n.nspname <> ALL 
           (ARRAY['pg_toast'::name
                 ,'pg_catalog'::name
                 ,'information_schema'::name]
           )
     )
);



