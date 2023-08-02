# DB Observability Notebooks
## About
Jupyter notebooks can be a powerful tool for quickly detecting database-related problems and gaining valuable insights into their root causes. By connecting to a database and leveraging data analysis libraries like pandas and matplotlib, data analysts can quickly explore and visualize the data, identify anomalies, and troubleshoot issues.

The DB Observability Notebook project is an open-source initiative that offers Jupyter Notebooks as a useful resource for resolving database-related problems. These Notebooks provide SQL commands and insights, which are later integrated into the [Metis](https://www.metisdata.io/) DB guardrail platform to create an automated investigation flow.

## The Main Building Blcoks
### SQL Commands Drafts
This folder contains many useful SQL commands **as is**. Some commands might overlap. 

### OpenCMD python class
A python library to run SQL Commands by providing name and parameters. The SQL commands taken from a curated list of YAML files. 

### Observability Notebooks
Jupyter notebooks to show useful information about the internal state of the Postgres server. 
The notebooks should use the OpenCMD to keep the code clean, without showing any SQL. 
The notebooks also visualize the data. 

### OpenInsights Notebooks
These Jupyter notebooks are the final goal: show insights about your PG server, instead of raw data. The insights give you the power of an experienced DBA, help you to understand the problems and how to solve them. 
