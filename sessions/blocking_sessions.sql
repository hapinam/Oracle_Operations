------------------------------------------------------------------------------
-- Script    : sessions/blocking_sessions.sql
-- Purpose   : Show the sessions that are currently blocking other sessions,
--             with the OS user, program and machine behind them.
-- Usage     : sqlplus / as sysdba @sessions/blocking_sessions.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select SADDR, SID, SERIAL#, MODULE, ACTION,substr(s.username,1,15) "username",
STATUS,substr(s.OSUSER,1,30) "osuser",
substr(s.PROGRAM,1,20) "OS PROGRAM",s.machine
from v$session s
where SID in (select sid from v$lock where block=1);
