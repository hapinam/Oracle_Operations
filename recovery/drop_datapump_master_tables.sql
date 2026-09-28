------------------------------------------------------------------------------
-- Script    : recovery/drop_datapump_master_tables.sql
-- Purpose   : Find and drop orphaned Data Pump master tables left behind by
--             failed or killed export and import jobs.
-- Usage     : sqlplus / as sysdba @recovery/drop_datapump_master_tables.sql
-- Requires  : SELECT_CATALOG_ROLE plus DROP ANY TABLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Only drop master tables of jobs that are genuinely NOT
--             RUNNING. Dropping the master table of a live job kills that
--             job and makes it unresumable.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- 1. List Data Pump jobs and their state. Only NOT RUNNING jobs are orphans.
SELECT owner_name, job_name, operation, job_mode, state, attached_sessions
FROM   dba_datapump_jobs
ORDER  BY owner_name, job_name;

-- 2. The master table has the same name as the job. Confirm it exists.
SELECT owner, table_name, num_rows, last_analyzed
FROM   dba_tables
WHERE  owner = UPPER('&&job_owner')
AND    table_name = UPPER('&&job_name');

-- 3. Drop the master table of the orphaned job.
-- DROP TABLE &&job_owner..&&job_name PURGE;

UNDEFINE job_owner
UNDEFINE job_name
