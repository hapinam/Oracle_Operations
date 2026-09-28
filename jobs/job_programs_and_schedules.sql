------------------------------------------------------------------------------
-- Script    : jobs/job_programs_and_schedules.sql
-- Purpose   : List scheduler jobs with their programs, schedules, state and
--             next run date.
-- Usage     : sqlplus / as sysdba @jobs/job_programs_and_schedules.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select JOB_NAME,STATUS,LOG_DATE,ADDITIONAL_INFO
from ALL_SCHEDULER_JOB_LOG
where OWNER in ('TEMP','DISCWEB')
order by LOG_DATE,job_name;

SELECT JOB_NAME, max_runs,STATE,ENABLED,START_DATE,NEXT_RUN_DATE,LAST_RUN_DURATION
FROM ALL_SCHEDULER_JOBS
where owner in ('TEMP','DISCWEB')
order by start_date;

SELECT  OWNER,PROGRAM_NAME,PROGRAM_TYPE,ENABLED,SUBSTR(PROGRAM_ACTION,1,70)
FROM ALL_SCHEDULER_PROGRAMS
where owner in ('TEMP','DISCWEB') ;
