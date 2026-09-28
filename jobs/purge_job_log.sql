------------------------------------------------------------------------------
-- Script    : jobs/purge_job_log.sql
-- Purpose   : Purge the scheduler log to stop SYSAUX growing because of job
--             history.
-- Usage     : sqlplus / as sysdba @jobs/purge_job_log.sql
-- Requires  : MANAGE SCHEDULER
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : PURGE_LOG deletes job history permanently. Keep enough
--             retention to satisfy your audit requirements.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- How much history is there, and how old is it?
SELECT TRUNC(log_date) AS day, COUNT(*) AS entries
FROM   dba_scheduler_job_log
GROUP  BY TRUNC(log_date)
ORDER  BY 1;

-- Purge everything older than 30 days, keeping recent history for auditing.
EXEC DBMS_SCHEDULER.PURGE_LOG(log_history => 30);

-- Purge the history of a single job only.
-- EXEC DBMS_SCHEDULER.PURGE_LOG(log_history => 0, which_log => 'JOB_LOG', job_name => '&&job_name');

-- Keep it under control from now on: the scheduler purges automatically
-- according to this attribute (days).
EXEC DBMS_SCHEDULER.SET_SCHEDULER_ATTRIBUTE('log_history', '30');
