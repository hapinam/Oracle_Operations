------------------------------------------------------------------------------
-- Script    : sessions/locks.sql
-- Purpose   : Show current locks, the objects locked and the sessions
--             holding or waiting for them.
-- Usage     : sqlplus / as sysdba @sessions/locks.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select
(select username || ' - ' || osuser from v$session where sid=a.sid) blocker,
a.sid || ', ' ||
(select serial# from v$session where sid=a.sid) sid_serial,
' is blocking ',
(select username || ' - ' || osuser from v$session where sid=b.sid) blockee,
b.sid || ', ' ||
(select serial# from v$session where sid=b.sid) sid_serial
from v$lock a, v$lock b
where a.block = 1 and b.request > 0 and a.id1 = b.id1 and a.id2 = b.id2;
