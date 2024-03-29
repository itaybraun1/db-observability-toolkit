/************************************************************************

	### table_io_waits_summary_by_index_usage ###
	Link: https://dev.mysql.com/doc/mysql-perfschema-excerpt/8.0/en/performance-schema-table-io-waits-summary-by-index-usage-table.html
  
  Desc: The table_io_waits_summary_by_index_usage table aggregates all table index I/O wait events, as generated by the wait/io/table/sql/handler instrument. The grouping is by table index.
	The columns of table_io_waits_summary_by_index_usage are nearly identical to table_io_waits_summary_by_table. The only difference is the additional group column, INDEX_NAME, which corresponds to the name of the index that was used when the table I/O wait event was recorded:
		- A value of PRIMARY indicates that table I/O used the primary index.
		- A value of NULL means that table I/O used no index.
    - Inserts are counted against INDEX_NAME = NULL.
************************************************************************/
SELECT 
    object_schema, 
	object_name,
    index_name, 
    count_star, -- A summry of both COUNT_READ and COUNT_WRITE
    count_read, 
    count_insert, 
    count_update, 
    count_delete, 
    sum_timer_read,
    sum_timer_write, 
    sum_timer_insert, 
    sum_timer_update, 
    sum_timer_delete 
FROM performance_schema.table_io_waits_summary_by_index_usage
