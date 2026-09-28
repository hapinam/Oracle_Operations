------------------------------------------------------------------------------
-- Script    : sessions/long_operations.sql
-- Purpose   : Show long running operations from V$SESSION_LONGOPS with the
--             percentage complete.
-- Usage     : sqlplus / as sysdba @sessions/long_operations.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select sid, username, opname, target, sofar, totalwork,  units, elapsed_seconds, to_char(start_time,'DD-Mon-YYYY hh24:mi:ss') stime, message,time_remaining "Remaining time in seconds" , round(( sofar/totalwork)* 100) percent
from v$session_longops
where sofar/totalwork < 1 and totalwork != 0
--and username not in ('SYS','SYSTEM')
--and sid in (5215, 9536)
order by start_time desc;
