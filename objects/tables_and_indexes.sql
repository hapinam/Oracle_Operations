------------------------------------------------------------------------------
-- Script    : objects/tables_and_indexes.sql
-- Purpose   : List tables with their indexes and sizes for a schema.
-- Usage     : sqlplus / as sysdba @objects/tables_and_indexes.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

SELECT INDEX_NAME,TABLE_NAME,TABLESPACE_NAME,TABLE_OWNER,STATUS
FROM DBA_INDEXES
WHERE TABLE_OWNER='OWNER' and TABLE_NAME=('TABLE_NAME')
ORDER BY INDEX_NAME;
