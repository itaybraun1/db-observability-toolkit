-- Table: metis.pg_stat_database_snapshots
-- Version: 0.0.1
-- Description: Snapshots of data from the system table pg_stat_database 
-- Resources: https://pgstats.dev/pg_stat_database 

-- A Cron Job to populate the table metis.pg_stat_database_snapshots with db activity

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

-- Function Name: metis.get_db_activity
-- Description: gets the db activity rate of about 15 db activity metrics. 
-- Version 0.1.0
CREATE OR REPLACE FUNCTION metis.get_db_activity(
    start_datetime timestamp with time zone,
    end_datetime timestamp with time zone,
    group_by_time_period text
) RETURNS TABLE (
    previous_snapshot_id int,
    previous_insert_date timestamp,
    current_snapshot_id int,
    current_insert_date timestamp,
    tup_fetched_difference bigint,
    numbackends_difference int,
    xact_commit_difference bigint,
    xact_rollback_difference bigint,
    blks_read_difference bigint,
    blks_hit_difference bigint ,
    tup_returned_difference bigint,
    tup_inserted_difference bigint,
    tup_updated_difference bigint,
    tup_deleted_difference bigint,
    conflicts_difference bigint,
    temp_files_difference bigint,
    temp_bytes_difference bigint,
    deadlocks_difference bigint,
    blk_read_time_difference double precision,
    blk_write_time_difference double precision,
    stats_reset_difference interval ,
    time_difference_seconds double precision 
) AS $$
BEGIN
    IF group_by_time_period = 'MINUTE' THEN
        RETURN QUERY (
            SELECT
                s1.snapshot_id AS previous_snapshot_id,
                s1.insert_date AS previous_insert_date,
                s2.snapshot_id AS current_snapshot_id,
                s2.insert_date AS current_insert_date,
                s2.tup_fetched - s1.tup_fetched AS tup_fetched_difference,
                s2.numbackends - s1.numbackends AS numbackends_difference,
                s2.xact_commit - s1.xact_commit AS xact_commit_difference,
                s2.xact_rollback - s1.xact_rollback AS xact_rollback_difference,
                s2.blks_read - s1.blks_read AS blks_read_difference,
                s2.blks_hit - s1.blks_hit AS blks_hit_difference ,
                s2.tup_returned - s1.tup_returned AS tup_returned_difference,
                s2.tup_inserted - s1.tup_inserted AS tup_inserted_difference,
                s2.tup_updated - s1.tup_updated AS tup_updated_difference,
                s2.tup_deleted - s1.tup_deleted AS tup_deleted_difference,
                s2.conflicts - s1.conflicts AS conflicts_difference,
                s2.temp_files - s1.temp_files AS temp_files_difference,
                s2.temp_bytes - s1.temp_bytes AS temp_bytes_difference,
                s2.deadlocks - s1.deadlocks AS deadlocks_difference,
                s2.blk_read_time - s1.blk_read_time AS blk_read_time_difference,
                s2.blk_write_time - s1.blk_write_time AS blk_write_time_difference,
                s2.stats_reset - s1.stats_reset AS stats_reset_difference,
          /* For some reason I had to manually convert the data type*/
                EXTRACT(EPOCH FROM (s2.insert_date - s1.insert_date))::double precision AS time_difference_seconds  
            FROM
                metis.pg_stat_database_snapshots s1
            JOIN
                metis.pg_stat_database_snapshots s2 ON s2.snapshot_id = s1.snapshot_id + 1
            WHERE
                s1.insert_date >= start_datetime
                AND s2.insert_date <= end_datetime
            ORDER BY
                s1.insert_date
        );
    ELSE
        RAISE EXCEPTION 'Invalid value for group_by_time_period. Valid value is "MINUTE".';
    END IF;
END;
$$ LANGUAGE plpgsql;

/*  Example how to call the function 
SELECT * FROM metis.get_db_activity(
    NOW() - INTERVAL '10 HOURS',  -- Start datetime 10 hours ago
    NOW(),                         -- End datetime is now
    'MINUTE'                       -- Group by minute
);
*/