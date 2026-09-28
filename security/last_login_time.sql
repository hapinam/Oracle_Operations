------------------------------------------------------------------------------
-- Script    : security/last_login_time.sql
-- Purpose   : Report the last successful logon time of each database
--             account, used to find dormant users.
-- Usage     : sqlplus / as sysdba @security/last_login_time.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

###to determine the last login time for each user:
--------------------------------------------------

select * from USER$
