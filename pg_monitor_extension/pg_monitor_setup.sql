/**************** SETUP ****************
Step 1 - Install the extension pg_stat_statement and pg_cron
Step 2 - Create the tables 
- Table: metis.pg_stat_database_snapshots
*****************/

-- Verify the extensions exists


-- run as superuser:
CREATE EXTENSION pg_cron;

--It is recommended to  grant usage to the user metis, created just for the monitoring. 
GRANT USAGE ON SCHEMA cron TO metis;