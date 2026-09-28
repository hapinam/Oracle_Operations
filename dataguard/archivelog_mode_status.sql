------------------------------------------------------------------------------
-- Script    : dataguard/archivelog_mode_status.sql
-- Purpose   : Report the archive log mode, destinations and current log
--             sequence of the database.
-- Usage     : sqlplus / as sysdba @dataguard/archivelog_mode_status.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

###To check whether database is archivelog or not
--------------------------------------------------

SQL>archive log list
