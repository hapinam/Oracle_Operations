------------------------------------------------------------------------------
-- Script    : objects/unusable_indexes.sql
-- Purpose   : List index partitions left in an UNUSABLE state, usually after
--             a partition maintenance operation.
-- Usage     : sqlplus / as sysdba @objects/unusable_indexes.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : An unusable index is silently ignored by the optimizer and
--             makes queries slower. Rebuild every partition returned here.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select substr(index_owner,1,10) "owner",
substr(index_name,1,20) "partitioned index",
substr(partition_name,1,10) "partition name",
substr(tablespace_name,1,15) "tablespace name"
from dba_ind_partitions
where status in ('UNUSABLE','UNVISIBLE')
order by index_name;
