------------------------------------------------------------------------------
-- Script    : objects/generate_disable_constraints.sql
-- Purpose   : Generate the ALTER TABLE statements needed to disable all non
--             key constraints in the current schema.
-- Usage     : sqlplus / as sysdba @objects/generate_disable_constraints.sql
-- Requires  : Ownership of the tables (reads USER_CONSTRAINTS)
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : This only generates statements; disabling constraints allows
--             invalid data in. Re enable and validate them afterwards.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

SELECT 'ALTER TABLE '||TABLE_NAME||' DISABLE CONSTRAINT '
||CONSTRAINT_NAME||';' FROM USER_CONSTRAINTS
WHERE CONSTRAINT_TYPE not in ('P','U')
ORDER BY TABLE_NAME;
