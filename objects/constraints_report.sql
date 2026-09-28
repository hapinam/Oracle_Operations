------------------------------------------------------------------------------
-- Script    : objects/constraints_report.sql
-- Purpose   : List constraints and their columns for a table, including
--             foreign keys pointing at it.
-- Usage     : sqlplus / as sysdba @objects/constraints_report.sql
-- Requires  : SELECT on the data dictionary (SELECT_CATALOG_ROLE) or ownership
--             of the table
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select a.owner, a.table_name "child tables",a.constraint_name "constraint to be disabled"
from dba_constraints a,dba_constraints b
where a.constraint_type='R' and  a.r_constraint_name= b.constraint_name and (b.constraint_type='P' or b.constraint_type='U' )
order by a.owner;
