# pg_monitor 
An extension for monitoring a PostgreSQL database 

## About
This extension collects metadata from the system table. It is used to understand time-based measures. 
For ex: 
- Database activity: number of rows read, written, transactions aborted...
- Database size: 
- Table activity: 
- Index activity: 
- Queries stats: query avg duration, calls and number of rows

## Data Flow
We tried to kep it simple with minimum moving parts, while ensuring a good response time. 
- Cron jobs run every X minutes to populate tables with snapshots of the data. Most of thd data collected every 1 minute. 
- An SQL function calculates the change rate (by minute or by hour) 
- Other cron jobs delete old data. 


Setup
1. Create the extension pg_stat_statement
2. Create the extension pg_cron
3. Create a new user for the monitoring, with least privileges
4. Create a new schema - Metis
4. Create tables
5. Create Cron jobs to populate the tables with data.
6. View the data, using functions, from the Observability Notebooks. 
