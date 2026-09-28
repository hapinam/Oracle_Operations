------------------------------------------------------------------------------
-- Script    : sessions/memory_per_session.sql
-- Purpose   : Report PGA and UGA memory used per session, to find the
--             sessions driving memory pressure.
-- Usage     : sqlplus / as sysdba @sessions/memory_per_session.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select e.sid, e.username,e.status,a.uga_memory,b.pga_memory
from
(select y.SID, TO_CHAR(ROUND(y.value/1024),99999999) || ' KB' UGA_MEMORY
from v$sesstat y, v$statname z
where y.STATISTIC# = z.STATISTIC# and NAME = 'session uga memory') a,
(select y.SID, TO_CHAR(ROUND(y.value/1024),99999999) || ' KB' PGA_MEMORY
from v$sesstat y, v$statname z
where y.STATISTIC# = z.STATISTIC# and NAME = 'session pga memory') b,
v$session e
where e.sid=a.sid and e.sid=b.sid
order by e.status, a.uga_memory desc;
