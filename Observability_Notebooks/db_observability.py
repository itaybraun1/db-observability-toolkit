import sqlalchemy
import pandas as pd
import configparser
import matplotlib.pyplot as plt 
from IPython.display import HTML

class infra:
    def __init__(self, config_file_path):
        self.config_file_path = config_file_path
        self.engine = None
        self.connection = None
    
    def open_db_connection(con_str_name) -> sqlalchemy.engine.base.Connection:
        try: 
            config = configparser.ConfigParser() 
            config.read_file(open(r'../ipynb.cfg'))
        except Exception as e:
            print(f"Error opening the configuration file: {e}")

        try: 
            con_str = config.get('con_str', con_str_name)
            engine = sqlalchemy.create_engine(con_str)
            connection = engine.connect()
            print("Connecting with engine " + str(engine))
            return connection
        except Exception as e:
            print(f"Error opening the configuration file: {e}")

    def add(int1, int2) -> int:
        return int1 + int2
