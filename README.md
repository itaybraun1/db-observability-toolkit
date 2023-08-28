# Database Observability Toolkit for Developers
## About
The Database Observability Toolkit is an open-source project designed to simplify the intricate task of monitoring and managing databases for developers. Given the complexity of databases and the fact that many developers may not possess an in-depth understanding of their inner workings, our project strives to provide a comprehensive, clear, and actionable set of tools. These tools empower developers to seamlessly detect, comprehend, and effectively resolve database-related issues.

## Key Features
Our project centers on providing an intuitive and developer-centric experience, encompassing the following key features:
- **Real-time Monitoring:** Gain real-time insights into your database's performance and resource utilization. Detect unusual patterns and spikes that could adversely affect your application's performance.
- **Query Analysis:** Dive into the impact of queries on your database's performance. Identify sluggish queries, scrutinize execution plans, and optimize queries to enhance efficiency.
- **Historical Data:** Access historical data to discern trends and patterns over time. Such historical insight is invaluable for capacity planning and identifying long-term performance tendencies.
- **Troubleshooting Guides:** Benefit from actionable guidance when issues are uncovered. The toolkit supplies troubleshooting steps and recommendations to address commonplace database predicaments.

## Key Modules

Our project is composed of three key modules, each catering to a specific aspect of database observability:

### SQL Queries Library

The **SQL Queries Library** serves as a curated repository of valuable SQL commands. These commands are meticulously crafted or sourced from high-quality blog posts. By providing a well-organized collection of useful queries, we equip developers with a valuable resource to better understand their databases.

### DB Observability Notebooks

The **DB Observability Notebooks** module takes the curated SQL queries and transforms them into actionable insights. These notebooks execute the queries against the monitored databases and present developers with meaningful information. This empowers developers to proactively monitor their databases' performance, track trends, and pinpoint areas that require attention.

### Troubleshooting Flows

Arguably the most significant module, **Troubleshooting Flows**, offers predefined, step-by-step workflows designed to swiftly tackle specific problems. These flows are tailored to guide developers through a systematic approach to root cause analysis. They pose crucial questions to identify potential issues, interpret query results, and provide clear explanations. This module acts as a compass for developers navigating complex database issues.

## Included Observability Notebooks

The **DB Observability Notebooks** module within the Database Observability Toolkit offers a collection of insightful notebooks that enable developers to delve into various aspects of database performance and health. These notebooks leverage the curated SQL queries and present valuable information in an accessible format. Here are some of the included notebooks:

- **CPU Usage Analysis**
- **Memory Usage Insights**
- **Database Size Overview**
- **Tables Size and Bloat Analysis**
- **Indexes Activity Examination**
- **Buffer Cache Utilization Insights**

[Explore Notebooks](https://github.com/itaybraun1/db-observability-toolkit/tree/main/Notebooks)

## The Power of Jupyter Notebooks for Problem Analysis

[Jupyter Notebooks](https://jupyter.org/) offer an integrated environment for problem analysis by combining code, rich visualization, and contextual documentation. Here's why they are a great tool for dissecting complex issues:

- **Code Integration:** Seamlessly combine code execution with explanatory text.

- **Rich Visualization:** Generate interactive visualizations such as graphs, plots, and diagrams.

- **Contextual Documentation:** Provide context, explanations, and links through Markdown text, offering comprehensive documentation alongside code.

- **Interactive Exploration:** Modify code on-the-fly, adjust parameters, and instantly observe changes in results to facilitate experimentation.

- **Collaboration and Sharing:** Easily share and collaborate on notebooks.  
  

# Getting Started
---------------------------------------------------------------
### Step 1 - Prepare the PostgreSQL Database you would like to monitor. 
- Create the extension pg_stat_statements
- Create the extension pg_buffercache (optional)

### Step 2 - Configure a connection string to the Postgres Server
The notebooks expet a configuration file. Use the file ```ipynb.cfg.changeme```. Rename it to ```ipynb.cfg```.   
Configure a connection string to a Postgres server. If you are using AWS RDS for Postgres, then you can (optional) configure AWS credentials too. 
If the notebook name contains the word "aws" then it uses the AWS credentials. Else, it uses plain SQL which can work with any PG server: AWS, GCS, Azure, Neon, K8s...

The configuration file should look similar to this: 
```yaml 
[credentials]
  ACCESS_KEY_ID = AKABCDEFGHIJKLMN42
  SECRET_ACCESS_KEY = ABCD1234EFGH5678LKJHGFD09876
[con_str]
  PG_AIRBASES = postgresql://postgres:paswword@pg1.abcdefgh.eu-central-1.rds.amazonaws.com:5432/dbname
```
### Step 3 - view the data using Jupyter Notebooks
There are many ways to view Jupyter notebooks. One popular option is using VS Code with the Jupyter Extension. It can be found in the [VS Code marketplace](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter). 
  

## Getting Involved
We invite developers, database administrators, and enthusiasts to actively participate in the growth of the Database Observability Toolkit:

- **SQL Contributions:** Contribute to the SQL Queries Library by suggesting valuable SQL commands or sharing queries that have proven effective in your experience.

- **Notebook Enhancements:** Help enhance the DB Observability Notebooks by refining query execution, result visualization, and insights generation.

- **Troubleshooting Expertise:** Contribute your troubleshooting expertise to improve existing flows or create new ones that cover a wider range of database challenges.

- **Spread the Word:** Share the project with fellow developers who could benefit from simplified database observability.

# About Metis
The DB Observability Toolkit created by [metis](https://www.metisdata.io/) . Metis platform prevent your database code from breaking production. You can [sign up here](https://oauth.app.metisdata.io/oauth/account/login?). The platform offers rich functionality and a generous free tier.  