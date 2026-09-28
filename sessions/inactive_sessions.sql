------------------------------------------------------------------------------
-- Script    : sessions/inactive_sessions.sql
-- Purpose   : List inactive sessions with their idle time, to find
--             connections that should be closed by the application.
-- Usage     : sqlplus / as sysdba @sessions/inactive_sessions.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select machine,osuser,username,count(*)
from v$session
where status='INACTIVE'
group by machine,osuser,username
order by 4 desc;
