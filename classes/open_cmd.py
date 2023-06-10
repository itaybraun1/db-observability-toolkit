import psycopg2
import pandas as pd
from sqlalchemy import create_engine
import yaml

class OpenCmd:
    
    
    def open_pg_connection(self, url):
        try:
            engine = create_engine(url)
            self.connection = engine.connect()
            print("Connection opened successfully.")
        except Exception as e:
            print(f"Error opening connection: {e}")

    # Adds a new SQLCmd to the array pg_sql_cmds[]
    def add_sql_cmd(self, name, description, sql):
            sql_cmd = SQLCmd(name, description, sql)
            self.pg_sql_cmds.append(sql_cmd)

    def generatePGCommands(self):
        self.add_sql_cmd("pg_class", "Description of Command 1", "SELECT * from pg_class")

        self.add_sql_cmd("databases", "Shows the databases on the PG server", """
        SELECT pg_database.datname AS database_name, 
pg_database_size(pg_database.datname) as size_kb, 
pg_size_pretty(pg_database_size(pg_database.datname)) AS size
FROM pg_database
ORDER BY pg_database.datname ASC;
""")
        self.add_sql_cmd("tables_size", "Shows user tables and their size", """
        SELECT relid,
		schemaname, 
    relname as table_name, 
    (schemaname || '.' || relname) as full_table_name,
    n_live_tup as rows,
    n_dead_tup as dead_rows,
    n_mod_since_analyze,
    case 
    	when n_live_tup = 0 THEN 0
      else  n_mod_since_analyze / n_live_tup 
      end as pct_mod_since_analyze,
    last_analyze as last_analyze_date,
    last_autoanalyze as last_autoanalyze_date,
    pg_total_relation_size(relid) / 1024 as total_table_size_kb, 
    pg_table_size(relid) / 1024 as table_size_kb,
    pg_indexes_size(relid) / 1024 as indexes_size_kb,
    pg_size_pretty(pg_total_relation_size(relid)) as total_table_size_pretty, 
    pg_size_pretty(pg_table_size(relid)) as table_size_pretty,
    pg_size_pretty(pg_indexes_size(relid)) as index_size_pretty
    
FROM pg_stat_user_tables
ORDER BY schemaname, 
    relname""")
       
        self.add_sql_cmd("Command 4", "Description of Command 4", "UPDATE table4 SET column1 = value1 WHERE condition")
        self.add_sql_cmd("Command 5", "Description of Command 5", "DELETE FROM table5 WHERE condition")

    def __init__(self, name=None, description=None, sql=None):
        self.name = name
        self.description = description
        self.sql = sql
        self.connection = None
        self.pg_sql_cmds = []

        self.generatePGCommands()

    def generate_SQLCmd_from_yaml(self, yaml_file):
        print ("YAML FIle Path: " + yaml_file)
        try:
            with open(yaml_file, 'r') as file:
                data = yaml.safe_load(file)
            
            if data is None:
                raise ValueError("Empty or invalid YAML file")

            sql_cmds = []

            for item in data:
                name = item.get('name')
                description = item.get('description')
                sql = item.get('sql')
                db_engine = item.get('db-engine')
                parameters = item.get('parameters')

                # Create SQLCmd object
                sql_cmd = SQLCmd(name=name, description=description, sql=sql, db_engine=db_engine, parameters=parameters)

                sql_cmds.append(sql_cmd)

            return sql_cmds

        except (IOError, yaml.YAMLError) as e:
            print(f"Error reading YAML file: {e}")
            return []
    
    def showCmds(self, show_sql=False):
        data = []
        for sql_cmd in self.pg_sql_cmds:
            row = {'cmd_name': sql_cmd.name, 'description': sql_cmd.description}
            if show_sql:
                row['sql'] = sql_cmd.sql
            data.append(row)

        df = pd.DataFrame(data)
        print(df)

# Assume the connection is of type PG
    def run_cmd(self,  command_name):
        # first, check whether the command exists
        found_cmd = None
        for sql_cmd in self.pg_sql_cmds:
            if sql_cmd.name == command_name:
                found_cmd = sql_cmd
                break
        
        if found_cmd is None:
            raise ValueError("Command not found.")

        if self.connection is None or self.connection.closed:
            print(f"Coulnd not open the connection.")
            return
        
        try:
            df = pd.read_sql(found_cmd.sql, self.connection)
            print(f"Command '{command_name}' executed successfully.")
            return df
        except (psycopg2.OperationalError, psycopg2.Error) as e:
            print(f"Error executing command: {e}")

   

class SQLCmd:
   
    def __init__(self, name=None, description=None, sql=None, db_engine=None, parameters=None):
        self.name = name
        self.description = description
        self.sql = sql
        self.db_engine = db_engine
        self.parameters = parameters