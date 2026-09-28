------------------------------------------------------------------------------
-- Script    : security/audit_settings.sql
-- Purpose   : Show which statements, privileges and objects are currently
--             being audited.
-- Usage     : sqlplus / as sysdba @security/audit_settings.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

###list of users

select USERNAME,ACCOUNT_STATUS,LOCK_DATE,CREATED,PROFILE
from sys.dba_users;



###list of roles privilege

select * from sys.role_tab_privs;

###list of roles granted to users

select * from sys.dba_role_privs
where grantee not in (select role from sys.dba_roles);


###system privilege

select * from sys.dba_sys_privs;
