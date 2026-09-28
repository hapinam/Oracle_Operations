------------------------------------------------------------------------------
-- Script    : sessions/set_current_schema.sql
-- Purpose   : Switch the current schema of the session so unqualified object
--             names resolve to another owner.
-- Usage     : sqlplus / as sysdba @sessions/set_current_schema.sql
-- Requires  : CREATE SESSION
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- Unqualified object names now resolve to this owner for the rest of the
-- session. It does not grant any privilege on that schema.
ALTER SESSION SET current_schema = &&schema_name;

-- Confirm what the session is using.
SELECT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') AS current_schema,
       SYS_CONTEXT('USERENV','SESSION_USER')   AS session_user
FROM   dual;

UNDEFINE schema_name
