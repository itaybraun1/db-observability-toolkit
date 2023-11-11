-- https://www.pgmustard.com/blog/queries-for-pg-stat-statements
-- https://www.postgresql.org/docs/current/pgstatstatements.html
-- Top statements by total time

--Settings
-- A Query for the MMC v2: total exec time (excl planning), calls, read
-- total_plan_time double precision: Total time spent planning the statement, in milliseconds (if pg_stat_statements.track_planning is enabled, otherwise zero)
-- blk_read_time double precision: Total time the statement spent reading blocks, in milliseconds (if track_io_timing is enabled, otherwise zero)
SELECT  
	queryid, 
  query,
  calls,
	round(total_exec_time::numeric, 3) as exec_time,
  round(total_plan_time::numeric, 3) as exec_time,
  round((total_exec_time + total_plan_time)::numeric,3) as total_exec_time,
	rows,
	(shared_blks_hit + shared_blks_read + shared_blks_dirtied + shared_blks_written 
   + local_blks_hit + local_blks_read + local_blks_dirtied + local_blks_written 
   + temp_blks_read + temp_blks_written) * 8 as total_io_kb, 
  (temp_blks_read + temp_blks_written) * 8 as temp_io_kb, 
  blk_read_time, 
  blk_write_time
FROM pg_stat_statements
WHERE dbid = (SELECT oid FROM pg_database WHERE datname = current_database());

select * 
from pg_settings
where name like 'pg_stat_statements.%'

select
	(total_exec_time + total_plan_time)::int as total_time,
	total_exec_time::int,
	total_plan_time::int,
	mean_exec_time::int,
	calls,
	query
from
	pg_stat_statements
order by
	total_time desc
limit 50;


-- Top queries by CPU, includig DB name
SELECT 
        ps.userid,
        ps.dbid,
        pd.datname as db_name,
        round((ps.total_exec_time)::numeric, 2) as total_exec_time, 
        ps.calls, 
        round((ps.mean_exec_time)::numeric, 2) as mean_exec_time, 
        round((100 * (ps.total_exec_time + ps.total_plan_time) 
               / sum((ps.total_exec_time + ps.total_plan_time)::numeric) OVER ())::numeric, 2) as cpu_time_pct,
        ps.query
FROM pg_stat_statements as ps
	JOIN pg_database as pd
		ON pd.oid=ps.dbid
ORDER BY (ps.total_exec_time)DESC 
LIMIT 50;


-- By mean time
select
	(mean_exec_time + mean_plan_time)::int as mean_time,
	mean_exec_time::int,
	mean_plan_time::int,
	calls,
	query
from
	pg_stat_statements
--where
--	userid = 99999
--	and calls > 1
order by
	mean_time desc
limit 50;

-- Top IO consumers
--  pg_size_pretty() — and if you do, remember to multiply by your block size (8192 by default).
select
	shared_blks_hit + shared_blks_read + shared_blks_dirtied + shared_blks_written + local_blks_hit + local_blks_read + local_blks_dirtied + local_blks_written + temp_blks_read + temp_blks_written as total_buffers,
	(total_exec_time + total_plan_time)::int as total_time,
	calls,
	shared_blks_hit as sbh,
	shared_blks_read as sbr,
	shared_blks_dirtied as sbd, 
	shared_blks_written as sbw,
	local_blks_hit as lbh,
	local_blks_read as lbr,
	local_blks_dirtied as lbd,
	local_blks_written as lbw,
	temp_blks_read as tbr,
	temp_blks_written as tbr,
	query
from
	pg_stat_statements
order by
	total_buffers desc
limit 50;

-- JIT (only for pg15)
-- JIT: https://www.postgresql.org/docs/current/jit.html , 
-- Just-in-Time (JIT) compilation is the process of turning some form of interpreted program evaluation into a native program, and doing so at run time. For example, instead of using general-purpose code that can evaluate arbitrary SQL expressions to evaluate a particular SQL predicate like WHERE a.col = 3, it is possible to generate a function that is specific to that expression and can be natively executed by the CPU, yielding a speedup.
select
	((jit_generation_time + jit_inlining_time + jit_optimization_time + jit_emission_time)/(total_exec_time + total_plan_time)) as jit_total_time_percent,
	calls,
	jit_functions,
	jit_generation_time,
	jit_inlining_count,
	jit_inlining_time,
	jit_optimization_count,
	jit_optimization_time,
	jit_emission_count,
	jit_emission_time,
	query
from
	pg_stat_statements
order by
	jit_total_time_percent desc
limit 50;
