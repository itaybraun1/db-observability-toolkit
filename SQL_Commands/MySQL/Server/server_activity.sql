/*********************************
	### information_schema.GLOBAL_VARIABLES ###
	Desc: System overall status. The current value of some of the important variables, on the server level.  
	- 'Threads_connected': This will show you all the open connections.
**********************************/ 
SELECT
    VARIABLE_NAME,
    VARIABLE_VALUE
FROM
    information_schema.GLOBAL_VARIABLES
WHERE
    VARIABLE_NAME IN (
        'max_connections',
        'innodb_buffer_pool_size',
        'query_cache_type',
        'query_cache_size',
        'key_buffer_size',
        'innodb_log_file_size',
        'innodb_flush_log_at_trx_commit',
        'innodb_file_per_table',
        'innodb_flush_method',
        'innodb_lock_wait_timeout',
        'tmp_table_size',
        'max_heap_table_size',
        'table_open_cache',
        'thread_cache_size',
        'innodb_autoinc_lock_mode',
        'innodb_doublewrite',
        'innodb_flush_neighbors'
    );

