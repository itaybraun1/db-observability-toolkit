/**********
Script: Host_Metrics_DB
This script creates the objects in a new DB dedicated for DB cluster (host) metrics
*************/
-- Create a new schema "metis"
CREATE SCHEMA IF NOT EXISTS metis;

-- Create the extension pg_stat_statements
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;


--------   TABLES ----------
-- The table metis.pg_stat_database_history
CREATE TABLE IF NOT EXISTS metis.pg_stat_database_history (
    datid          OID,       -- Database ID
    datname        TEXT,      -- Database name
    numbackends    INTEGER,   -- Number of active connections
    xact_commit    BIGINT,    -- Total number of transactions committed
    xact_rollback  BIGINT,    -- Total number of transactions rolled back
    blks_read      BIGINT,    -- Total number of disk blocks read
    blks_hit       BIGINT,    -- Total number of disk blocks found in shared buffers
    tup_returned   BIGINT,    -- Total number of tuples returned by queries
    tup_fetched    BIGINT,    -- Total number of tuples fetched by queries
    tup_inserted   BIGINT,    -- Total number of tuples inserted
    tup_updated    BIGINT,    -- Total number of tuples updated
    tup_deleted    BIGINT,    -- Total number of tuples deleted
    conflicts      BIGINT,    -- Number of query conflicts
    temp_files     BIGINT,    -- Number of temporary files created
    temp_bytes     BIGINT,    -- Total size of temporary files
    deadlocks      BIGINT,    -- Total number of deadlocks detected
    blk_read_time  DOUBLE PRECISION, -- Time spent reading blocks (in milliseconds)
    blk_write_time DOUBLE PRECISION, -- Time spent writing blocks (in milliseconds)
    stats_reset    TIMESTAMP, -- Timestamp of the last statistics reset
    time           TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp of data insertion
);


---------  FUNCTIONS -------
-- The functions will be used later by pg_cron jobs to insert the data. 

CREATE OR REPLACE FUNCTION metis.print_message(p_message text) RETURNS void AS $$
BEGIN
    RAISE NOTICE '%', p_message;
END;
$$ LANGUAGE plpgsql;


%%sql 

CREATE OR REPLACE FUNCTION metis.insert_pg_stat_database_history() 
RETURNS VOID AS $$
BEGIN
    -- Insert the current data from pg_stat_database into metis.pg_stat_database_history
    INSERT INTO metis.pg_stat_database_history (
        datid,
        datname,
        numbackends,
        xact_commit,
        xact_rollback,
        blks_read,
        blks_hit,
        tup_returned,
        tup_fetched,
        tup_inserted,
        tup_updated,
        tup_deleted,
        conflicts,
        temp_files,
        temp_bytes,
        deadlocks,
        blk_read_time,
        blk_write_time,
        stats_reset,
        time  -- Default value of CURRENT_TIMESTAMP
    )
    SELECT 
        datid,
        datname,
        numbackends,
        xact_commit,
        xact_rollback,
        blks_read,
        blks_hit,
        tup_returned,
        tup_fetched,
        tup_inserted,
        tup_updated,
        tup_deleted,
        conflicts,
        temp_files,
        temp_bytes,
        deadlocks,
        blk_read_time,
        blk_write_time,
        stats_reset,
        CURRENT_TIMESTAMP  -- Insert timestamp
    FROM pg_stat_database
    WHERE datname NOT IN ('template1', 'template0')
		AND datname IS NOT NULL;
END;
$$ LANGUAGE plpgsql;



-------  VIEWS    ----------
-- Query the collected data using views. 