------------------------------------------------------------------------------
-- Script    : sessions/session_sql_text.sql
-- Purpose   : Show the SQL text each active session is currently running.
-- Usage     : sqlplus / as sysdba @sessions/session_sql_text.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select v.sid,s.sql_id,s.cpu_time,v.module,v.program,v.terminal,v.username,v.machine,v.osuser,s.sql_text
from v$sql s, v$session v
WHERE v.sql_address=s.address
AND v.sql_hash_value=s.hash_value
and v.status='ACTIVE' /*and sql_text like '%ALL_INSTR%'*/
order by 3 desc
