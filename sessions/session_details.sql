------------------------------------------------------------------------------
-- Script    : sessions/session_details.sql
-- Purpose   : Find the SID, serial number and OS process of a session from
--             the user, program or client machine.
-- Usage     : sqlplus / as sysdba @sessions/session_details.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select sid, SERIAL#, username, status, osuser, machine, program, sql_id, terminal, module, logon_time, client_info, client_identifier
from v$session
--where sid in (12613)
--or osuser='985'
--or status= 'ACTIVE'
order by logon_time;

--alter system kill session '12613,64775' immediate;
