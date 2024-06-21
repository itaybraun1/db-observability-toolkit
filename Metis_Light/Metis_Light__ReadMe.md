# Metis Light - Readme
This guide explains what steps are taken to implement the solution. Use the provided scripts to simplify the implementation. 

## Monitoring DB Cluster (Host) activity
A new DB is used to monitor the DB Cluster data
- Databases activity
- Slow Queries

### A dedicated DB for the DB Cluster level data
- Create a new database. For ex. "metis_1"
- Create a new schema in the DB  called "metis"
- Create the table ```metis.pg_stat_database_history```. It is used to store db activity, using pg_stat_database. 
- Create the function ```metis.insert_pg_stat_database_history``` to insert data to the table ```metis.pg_stat_database_history```.

### Create the pg_cron jobs
Remember that the pg_cron extension can be installed in only one DB. It might be created in another database. See the technical instruction what to do in this case
- Create a pg_cron job called ``` ``` to insert data to the table ```metis.pg_stat_database_history```

