------------------------------------------------------------------------------
-- Script    : jobs/gather_stats_job.sql
-- Purpose   : Create, run and drop a DBMS_SCHEDULER job that gathers
--             database wide optimizer statistics.
-- Usage     : sqlplus / as sysdba @jobs/gather_stats_job.sql
-- Requires  : CREATE ANY JOB plus ANALYZE ANY, normally SYSDBA
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Gathering statistics on a whole database is resource intensive
--             and changes execution plans. Run it in a maintenance window.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

EXEC DBMS_SCHEDULER.DROP_JOB ('RBM_STATS')

BEGIN
sys.dbms_scheduler.create_job(
job_name => '"SYS"."RBM_STATS"',
job_type => 'PLSQL_BLOCK',
job_action => 'begin
   dbms_stats.gather_database_stats( cascade => TRUE,degree=> 16,gather_sys=>TRUE,estimate_percent=> 1 ) ;
end;',
start_date => systimestamp at time zone '+2:00',
job_class => '"DEFAULT_JOB_CLASS"',
auto_drop => FALSE,
enabled => TRUE);
sys.dbms_scheduler.set_attribute( name => '"SYS"."RBM_STATS"', attribute => 'raise_events', value => dbms_scheduler.job_started + dbms_scheduler.job_succeeded + dbms_scheduler.job_failed + dbms_scheduler.job_completed + dbms_scheduler.job_stopped);
sys.dbms_scheduler.enable( '"SYS"."RBM_STATS"' );
END;



---------------------


BEGIN
sys.dbms_scheduler.create_job(
job_name => '"SYS"."REF_GATHER_STATS"',
job_type => 'PLSQL_BLOCK',
job_action => 'begin
   dbms_stats.gather_database_stats( cascade => TRUE,degree=> 16,gather_sys=>TRUE,method_opt=> ''FOR ALL COLUMNS SIZE 1'' ) ;
end;',
repeat_interval => 'FREQ=DAILY;BYHOUR=1;BYMINUTE=0;BYSECOND=0',
start_date => systimestamp at time zone 'Africa/Cairo',
job_class => '"DEFAULT_JOB_CLASS"',
auto_drop => FALSE,
enabled => FALSE);
sys.dbms_scheduler.set_attribute( name => '"SYS"."REF_GATHER_STATS"', attribute => 'raise_events', value => dbms_scheduler.job_started + dbms_scheduler.job_succeeded + dbms_scheduler.job_failed + dbms_scheduler.job_completed + dbms_scheduler.job_stopped);
sys.dbms_scheduler.enable( '"SYS"."REF_GATHER_STATS"' );
END;


----------------------


BEGIN
sys.dbms_scheduler.create_job(
job_name => '"SYS"."RBM_GATHER_STATS"',
job_type => 'PLSQL_BLOCK',
job_action => 'begin
   dbms_stats.gather_database_stats( cascade => TRUE,degree=> 16,gather_sys=>TRUE,method_opt=> ''FOR ALL COLUMNS SIZE 1'' ) ;
end;',
repeat_interval => 'FREQ=WEEKLY;BYDAY=FRI;BYHOUR=05;BYMINUTE=0;BYSECOND=0',
start_date => to_timestamp_tz('2017-07-28 Africa/Cairo', 'YYYY-MM-DD TZR'),
job_class => '"DEFAULT_JOB_CLASS"',
auto_drop => FALSE,
enabled => TRUE);
sys.dbms_scheduler.set_attribute( name => '"SYS"."RBM_GATHER_STATS"', attribute => 'raise_events', value => dbms_scheduler.job_started + dbms_scheduler.job_succeeded + dbms_scheduler.job_failed + dbms_scheduler.job_completed + dbms_scheduler.job_stopped);
sys.dbms_scheduler.enable( '"SYS"."RBM_GATHER_STATS"' );
END;
