------------------------------------------------------------------------------
-- Script    : dataguard/applied_archive_logs.sql
-- Purpose   : Show which archived redo logs have been applied, used to check
--             Data Guard apply progress and gaps.
-- Usage     : sqlplus / as sysdba @dataguard/applied_archive_logs.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

SELECT SEQUENCE#, FIRST_TIME, NEXT_TIME, APPLIED FROM V$ARCHIVED_LOG ORDER BY SEQUENCE#, FIRST_TIME DESC;
