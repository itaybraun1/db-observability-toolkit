
SELECT cron.schedule(
  	'pg_stat_tables_activity_snapshots',
    '*/1 * * * *', 
    '
        INSERT INTO metis.pg_stat_tables_activity_snapshots (
    schemaname,
    relname,
    seq_scan,
    seq_tup_read,
    idx_scan,
    idx_tup_fetch,
    n_tup_ins,
    n_tup_upd,
    n_tup_del,
    n_tup_hot_upd,
    n_live_tup,
    n_dead_tup,
    n_mod_since_analyze,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze,
    vacuum_count,
    autovacuum_count,
    analyze_count,
    autoanalyze_count
)
SELECT
    schemaname,
    relname,
    seq_scan,
    seq_tup_read,
    idx_scan,
    idx_tup_fetch,
    n_tup_ins,
    n_tup_upd,
    n_tup_del,
    n_tup_hot_upd,
    n_live_tup,
    n_dead_tup,
    n_mod_since_analyze,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze,
    vacuum_count,
    autovacuum_count,
    analyze_count,
    autoanalyze_count
FROM
    pg_stat_user_tables;
    ');


SELECT cron.schedule(
  	'pg_stat_database_snapshots',
    '*/1 * * * *', 
    '
        -- Your SQL query goes here
        INSERT INTO metis.pg_stat_database_snapshots 
					(datid, datname, numbackends, xact_commit, xact_rollback, blks_read, blks_hit, tup_returned, 
           tup_fetched, tup_inserted, tup_updated, tup_deleted, conflicts, temp_files, temp_bytes, 
           deadlocks, blk_read_time, blk_write_time, stats_reset, insert_date)
        SELECT datid, datname, numbackends, xact_commit, xact_rollback, blks_read, blks_hit, tup_returned, 
          tup_fetched, tup_inserted, tup_updated, tup_deleted, conflicts, temp_files, temp_bytes, 
          deadlocks, blk_read_time, blk_write_time, stats_reset, current_timestamp
        FROM pg_stat_database
        WHERE datname =  current_database();
    ');



-- The extension uses one job to delete old data. The job called once a day. It simple calls a function delete_old_data_periodically()
-- The function deletes old data. You can edit it to control how much history each Data Set should have. 
-- Currently every Data Set stores 7 days of history. 
-- Schedule: Every 1 day at 01:00 AM
SELECT cron.schedule(
  	'pg_monitor__delete_old_data',
    '0 1 * * *', 
    '
    SELECT delete_old_data_periodically()
   ');
   