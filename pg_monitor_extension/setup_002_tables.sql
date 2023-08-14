-- Create the schema metis
-- TODO: check whether the schema already exists
CREATE SCHEMA metis

DROP TABLE IF EXISTS metis.pg_stat_database_snapshots

-- metis.pg_stat_database_snapshots
-- Note: The schema should be unified, always startu with snapshot_id and insert_date. 
CREATE TABLE metis.pg_stat_database_snapshots (
    snapshot_id SERIAL PRIMARY KEY,
  	datid int,
    datname text,
    numbackends integer,
    xact_commit bigint,
    xact_rollback bigint,
    blks_read bigint,
    blks_hit bigint,
    tup_returned bigint,
    tup_fetched bigint,
    tup_inserted bigint,
    tup_updated bigint,
    tup_deleted bigint,
    conflicts bigint,
    temp_files bigint,
    temp_bytes bigint,
    deadlocks bigint,
    blk_read_time double precision,
    blk_write_time double precision,
    stats_reset timestamp without time zone,
    insert_date timestamp default current_timestamp
);


CREATE TABLE metis.pg_stat_tables_activity_snapshots (
    snapshot_id serial PRIMARY KEY,
    insert_date timestamp with time zone DEFAULT current_timestamp,
    schemaname name,
    relname name,
    seq_scan bigint,
    seq_tup_read bigint,
    idx_scan bigint,
    idx_tup_fetch bigint,
    n_tup_ins bigint,
    n_tup_upd bigint,
    n_tup_del bigint,
    n_tup_hot_upd bigint,
    n_live_tup bigint,
    n_dead_tup bigint,
    n_mod_since_analyze bigint,
    last_vacuum timestamp with time zone,
    last_autovacuum timestamp with time zone,
    last_analyze timestamp with time zone,
    last_autoanalyze timestamp with time zone,
    vacuum_count bigint,
    autovacuum_count bigint,
    analyze_count bigint,
    autoanalyze_count bigint
);




/********************     F U N C T I O N S         ************************/

CREATE OR REPLACE FUNCTION delete_old_data_periodically() 
RETURNS VOID 
AS $$
BEGIN
    DELETE FROM metis.pg_stat_tables_activity_snapshots
		WHERE insert_date <  NOW() - INTERVAL '7 DAY';
END;
$$ LANGUAGE plpgsql;