# DB Observability Notebooks
## About
Introducing Metis Light: Get insights about your PostgreSQL Database Performance 
In the realm of efficient database management, we introduce Metis Light - your **developer-first** DB observability solution. 

## Collecting Metadata

## Guidlines - What Developer-First Actually Means
The product was built based on the following principles: 
- **Simple Installation:** Plain SQL, everything happens in the PostgresSQL. The server monitor itself with minimum "moving parts". No need of another installation of docker agents or Prometheus agent. 
- **Immediate Value:** Gain instant access to essential metrics, real-time data, and historical analysis, enabling quick performance optimization.
- **Minimal Impact:** The system collects different metadata at different frequencies, to ensure the monitoring processes doesn't generate an overhead of the source DB.  
- **Troubleshooting:** Monitor the actual impact on performances, size on disk and jobs execution, to clearly see the system works as expected.  

## The UI: Jupyter Notebooks and Grafana Dashboards
The project is an open-source initiative that offers Jupyter Notebooks as a useful resource for resolving database-related problems. These Notebooks provide SQL commands and insights, which are later integrated into the [Metis](https://www.metisdata.io/) DB guardrail platform to create an automated investigation flow.

## Getting Started
### Notebooks - Direct PostgreSQL System Catalog
For some notebooks, a connection string is all that's required to retrieve data. It doesn't get any simpler than that. They can be used with any PG version 13 or higher. It only requires the extension pg_stat_statements, suported by any cloud vendor and the PG as a Service ones (Stackgres, Aiven, Neon, Supabase...)

### Notebooks - Deep Insights
For comprehensive database insights, we've developed specific jobs to monitor the system closely. No external agents like Prometheus are necessary. These insightful processes effectively track the database, identifying anomalies in real time.
The code uses plain SQL and the pg_cron extension. It designed to work with any cloud vendor 

### SQL Commands Drafts
This folder contains many useful SQL commands **as is**. You might find them useful, as this curated list of SQL commands eventually will become valuable notebooks / dashaboards.   

 