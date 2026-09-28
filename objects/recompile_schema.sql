------------------------------------------------------------------------------
-- Script    : objects/recompile_schema.sql
-- Purpose   : Recompile all objects of a schema with UTL_RECOMP, used after
--             a schema wide change.
-- Usage     : sqlplus / as sysdba @objects/recompile_schema.sql
-- Requires  : SYSDBA
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Recompiling invalidates dependent objects while it runs. Use a
--             maintenance window on busy systems.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

###recompile database objects:
------------------------------

@?/rdbms/admin/utlrp.sql

EXEC UTL_RECOMP.recomp_serial('SYS');
