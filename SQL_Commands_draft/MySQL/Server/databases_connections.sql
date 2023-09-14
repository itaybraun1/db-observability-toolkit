/******************************************** 
	### Connections of each DB and their status. ####
	### 	performance_schema.threads	###
  The threads table contains a row for each server thread. Each row contains information about a thread and indicates whether monitoring and historical event logging are enabled for it:
	Columns: 
  - PROCESSLIST_STATE : An action, event, or state that indicates what the thread is doing. For descriptions of PROCESSLIST_STATE values, see Examining Server Thread (Process) Information. ( https://dev.mysql.com/doc/refman/8.0/en/thread-information.html)
	- PROCESSLIST_COMMAND: For foreground threads, the type of command the thread is executing on behalf of the client, or Sleep if the session is idle. For descriptions of thread commands, see Examining Server Thread (Process) Information. The value of this column corresponds to the COM_xxx commands of the client/server protocol and Com_xxx status variables. See Server Status Variables
				Background threads do not execute commands on behalf of clients, so this column may be NULL.
**********************************************/
SELECT
    processlist_db AS database_name,
    PROCESSLIST_COMMAND,
    SUM (CASE PROCESSLIST_COMMAND WHEN 'sleep' then 0 else 1 END) as active_connections,
     SUM (CASE PROCESSLIST_COMMAND WHEN 'sleep' then 1 else 0 END) as idle_connections
FROM
    performance_schema.threads
WHERE
    processlist_db IS NOT NULL
GROUP BY
    processlist_db, PROCESSLIST_COMMAND;