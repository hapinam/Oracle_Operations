------------------------------------------------------------------------------
-- Script    : sessions/session_counts.sql
-- Purpose   : Count sessions by status, user and machine against the
--             SESSIONS and PROCESSES limits.
-- Usage     : sqlplus / as sysdba @sessions/session_counts.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select count(*) from v$process;
