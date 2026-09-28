------------------------------------------------------------------------------
-- Script    : objects/compare_table_columns.sql
-- Purpose   : Compare the column list of two tables, used before a rebuild
--             or a migration to confirm the structures match.
-- Usage     : sqlplus / as sysdba @objects/compare_table_columns.sql
-- Requires  : SELECT_CATALOG_ROLE, or ownership of both tables
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select * from dba_tab_columns t
where table_name='VSA_ISO_MSG_GUI_TMP'
and column_name not in( select column_name from dba_tab_columns where table_name='VSA_ISO_MSG_GUI' );

select * from dba_tab_columns t
where table_name='VSA_ISO_MSG_GUI'
and column_name not in( select column_name from dba_tab_columns where table_name='VSA_ISO_MSG_GUI_TMP' );
