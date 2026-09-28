------------------------------------------------------------------------------
-- Script    : storage/tablespace_usage.sql
-- Purpose   : Report tablespace free space, used space and percentage full,
--             plus the datafiles behind each tablespace.
-- Usage     : sqlplus / as sysdba @storage/tablespace_usage.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select * from(select owner,segment_name,bytes/(1024*1024) mb
              from dba_segments
              where tablespace_name = 'USERS'
              order by blocks desc);
