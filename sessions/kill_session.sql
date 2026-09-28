------------------------------------------------------------------------------
-- Script    : sessions/kill_session.sql
-- Purpose   : Find a session by user, program or SQL and terminate it,
--             including the OS level kill for a hung process.
-- Usage     : sqlplus / as sysdba @sessions/kill_session.sql
-- Requires  : ALTER SYSTEM KILL SESSION, and OS access to the database server
--             for the process level kill
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Killing a session rolls back its transaction and can take a
--             long time to recover. Killing the wrong process at OS level
--             can crash the instance.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

ALTER SYSTEM KILL SESSION 'SID,SERIAL';
