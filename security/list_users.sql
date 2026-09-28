------------------------------------------------------------------------------
-- Script    : security/list_users.sql
-- Purpose   : List database users with their default and temporary
--             tablespaces.
-- Usage     : sqlplus / as sysdba @security/list_users.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select substr(username,1,20) "user name",default_tablespace,temporary_tablespace
from dba_users
order by username;
