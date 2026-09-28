------------------------------------------------------------------------------
-- Script    : instance/timezone_version.sql
-- Purpose   : Check the database time zone and the DST time zone file
--             version, needed before an upgrade.
-- Usage     : sqlplus / as sysdba @instance/timezone_version.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select systimestamp from dual;
select dbtimezone, sessiontimezone from dual;
SELECT DBTIMEZONE FROM DUAL;
