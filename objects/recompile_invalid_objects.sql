------------------------------------------------------------------------------
-- Script    : objects/recompile_invalid_objects.sql
-- Purpose   : Generate and run the statements that recompile invalid objects
--             after a patch, upgrade or DDL change.
-- Usage     : sqlplus / as sysdba @objects/recompile_invalid_objects.sql
-- Requires  : ALTER ANY PROCEDURE / EXECUTE on UTL_RECOMP, normally SYSDBA
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Recompilation invalidates dependent objects while it runs and
--             can block application calls. Prefer a maintenance window.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select 'alter '||upper('&object_type')||' '||owner||'.'||object_name||' compile;'
from dba_objects where object_type=upper('&object_type')
AND status <> 'VALID' order by owner;
