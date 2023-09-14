-- This provides basic metrics per table in the current database for when autovacuum and analyze were last run (as well as manual maintenance).
-- https://pgxn.org/dist/pgtelemetry/doc/pgtelemetry.html#View:.autovacuum_stats.
SELECT pg_stat_user_tables.schemaname,
    pg_stat_user_tables.relname,
    pg_stat_user_tables.last_vacuum,
    date_part
  ('epoch'::text
       ,age
       (now(), pg_stat_user_tables.last_vacuum)
	) AS age_last_vacuum,
    pg_stat_user_tables.vacuum_count,
    pg_stat_user_tables.last_autovacuum,
    date_part ('epoch'::text,
               age(now() ,pg_stat_user_tables.last_autovacuum)
	) AS age_last_autovacuum,
    pg_stat_user_tables.autovacuum_count,
    pg_stat_user_tables.last_analyze,
    date_part
('epoch'::text
     , age
     (now
           ()
           , pg_stat_user_tables.last_analyze
     )
) AS age_last_analyze,
    pg_stat_user_tables.analyze_count,
    pg_stat_user_tables.last_autoanalyze,
    date_part
('epoch'::text
     , age
     (now
           ()
           , pg_stat_user_tables.last_autoanalyze
     )
) AS age_last_autoanalyze,
    pg_stat_user_tables.autoanalyze_count
FROM pg_stat_user_tables;
