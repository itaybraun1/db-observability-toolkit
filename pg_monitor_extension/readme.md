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

## Data Sets
| Dataset  | Description                 | Status   |
|----------|-----------------------------|----------|
| pg_stat_database_snapshots| Activity of the current DB  | Done   |
| pg_stat_tables_activity_snapshots| Activity of all tables in the DB | Missing function |

### pg_stat_tables_activity_snapshots
- Takes a sanpshot of each user table. The default frequency is every 1 minute, which might be too often for a busy DB. 
- By default the table only stores hisotry of the last 7 days. For a DB with 50 tables, that means 7 day * 24 hours * 60 minutes * 50 tables = 504,000 rows. So consider taking a snapshot every 5 minutes. 
- v0.1 - use a function to calculate the diff of every table. Future versions will store the data by hour and maybe even by day, to generate deep history trends. 

## Jobs
Each Data Set uses two jobs, one to insert new data and one to delete old data. 
However, some Data Sets might require more jobs to generate advanced data flows. 