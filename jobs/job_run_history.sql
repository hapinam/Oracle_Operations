------------------------------------------------------------------------------
-- Script    : jobs/job_run_history.sql
-- Purpose   : Read the scheduler run history and failure details for a job.
-- Usage     : sqlplus / as sysdba @jobs/job_run_history.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

SELECT * FROM ALL_SCHEDULER_JOB_LOG;
SELECT * FROM ALL_SCHEDULER_JOB_RUN_DETAILS;
