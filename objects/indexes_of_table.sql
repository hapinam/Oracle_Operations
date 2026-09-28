------------------------------------------------------------------------------
-- Script    : objects/indexes_of_table.sql
-- Purpose   : List the indexes of a table together with their indexed
--             columns and column order.
-- Usage     : sqlplus / as sysdba @objects/indexes_of_table.sql
-- Requires  : SELECT_CATALOG_ROLE, or ownership of the table
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- Indexes of a table with their columns, in index column order.
SELECT ic.index_owner, ic.index_name, ic.column_position, ic.column_name,
       i.index_type, i.uniqueness, i.status
FROM   all_ind_columns ic
JOIN   all_indexes i
  ON   i.owner = ic.index_owner AND i.index_name = ic.index_name
WHERE  ic.table_name = UPPER('&&table_name')
ORDER  BY ic.index_name, ic.column_position;

UNDEFINE table_name
