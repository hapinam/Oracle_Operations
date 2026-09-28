------------------------------------------------------------------------------
-- Script    : instance/show_parameters.sql
-- Purpose   : Read instance parameters, including the hidden underscore
--             parameters and their default status.
-- Usage     : sqlplus / as sysdba @instance/show_parameters.sql
-- Requires  : SELECT_CATALOG_ROLE, SYSDBA for hidden parameters
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Never change a hidden parameter without an Oracle Support note
--             that tells you to.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

show parameter broker

select name , value from v$parameter  where name like '%dg_broker%';
