------------------------------------------------------------------------------
-- Script    : security/users_with_dba_privileges.sql
-- Purpose   : List the accounts and roles that hold DBA or other powerful
--             system privileges.
-- Usage     : sqlplus / as sysdba @security/users_with_dba_privileges.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- Accounts and roles that hold the DBA role.
SELECT grantee, granted_role, admin_option, default_role
FROM   dba_role_privs
WHERE  granted_role = 'DBA'
AND    grantee NOT IN ('SYS','SYSTEM')
ORDER  BY grantee;

-- Accounts that hold other powerful system privileges directly.
SELECT grantee, privilege, admin_option
FROM   dba_sys_privs
WHERE  privilege IN ('SELECT ANY TABLE','ALTER SYSTEM','DROP ANY TABLE',
                     'GRANT ANY ROLE','GRANT ANY PRIVILEGE','BECOME USER',
                     'CREATE ANY PROCEDURE','EXECUTE ANY PROCEDURE')
AND    grantee NOT IN ('SYS','SYSTEM','DBA')
ORDER  BY grantee, privilege;
