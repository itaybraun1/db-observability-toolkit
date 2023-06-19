-- https://pgxn.org/dist/pgtelemetry/doc/pgtelemetry.html
SELECT c.oid
,
    
(c.oid)::regclass AS relation
,
    pg_relation_size
(
     (t.oid)::regclass
) AS exclusive_bytes
,
    pg_size_pretty
(pg_relation_size
     (
           (t.oid)::regclass
     )
) AS exclusive_size
   
FROM (
     (pg_class c
     
        JOIN pg_class t 
          ON (
                 (
                       (t.relname)::text = 
                       ('pg_toast_'::text || 
                             (c.oid)::text
                       )
                 )
           )
     )
     
  JOIN pg_namespace n 
    ON (
           (c.relnamespace = n.oid)
     )
);