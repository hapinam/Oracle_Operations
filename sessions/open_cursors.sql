------------------------------------------------------------------------------
-- Script    : sessions/open_cursors.sql
-- Purpose   : Show open cursors per session against the OPEN_CURSORS limit,
--             to diagnose ORA-01000.
-- Usage     : sqlplus / as sysdba @sessions/open_cursors.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select  max(a.value) as highest_open_cur, p.value as max_open_cur
from v$sesstat a, v$statname b, v$parameter p
where  a.statistic# = b.statistic#
and b.name = 'opened cursors current'
and p.name= 'open_cursors' group by p.value;
