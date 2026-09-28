------------------------------------------------------------------------------
-- Script    : storage/tablespace_fragmentation.sql
-- Purpose   : Measure free space fragmentation inside tablespaces and find
--             segments whose extents are badly fragmented.
-- Usage     : sqlplus / as sysdba @storage/tablespace_fragmentation.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select tablespace_name,count(*) "amount of freg.",max(blocks),sum(blocks) "free blocks"
from sys.dba_free_space
group by tablespace_name
order by tablespace_name;
