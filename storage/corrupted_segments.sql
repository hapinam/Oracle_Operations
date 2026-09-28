------------------------------------------------------------------------------
-- Script    : storage/corrupted_segments.sql
-- Purpose   : Map corrupted blocks reported in V$DATABASE_BLOCK_CORRUPTION
--             back to the segments that own them.
-- Usage     : sqlplus / as sysdba @storage/corrupted_segments.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Any row returned means real block corruption. Open an Oracle
--             SR and recover the affected blocks with RMAN BLOCKRECOVER.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

SELECT SEGMENT_TYPE,OWNER||'.'||SEGMENT_NAME
FROM DBA_EXTENTS
WHERE FILE_ID = 12 AND 17116 BETWEEN BLOCK_ID
AND BLOCK_ID+BLOCKS -1;
