------------------------------------------------------------------------------
-- Script    : security/reset_user_to_previous_password.sql
-- Purpose   : Read the stored password verifier of a user and restore it
--             with IDENTIFIED BY VALUES after a temporary password change.
-- Usage     : sqlplus / as sysdba
--             @security/reset_user_to_previous_password.sql
-- Requires  : SYSDBA (SYS.USER$ is not granted to ordinary DBA accounts)
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Password verifiers are credentials. Never commit real output
--             of this script, never mail it, and clear your terminal
--             scrollback afterwards.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- 11gR2: build the ALTER USER statement from the verifier held in the
-- user metadata, before changing the password to a temporary one.
SELECT 'alter user "'||username||'" identified by values '''
       ||EXTRACT(XMLTYPE(dbms_metadata.get_xml('USER', username)),
                 '//USER_T/PASSWORD/text()').getStringVal()
       ||''' account unlock;' AS old_password
FROM   dba_users
WHERE  username = '&&account_name';

-- 12c and later: the whole account DDL, turned into an ALTER USER.
SELECT REPLACE(dbms_metadata.get_ddl('USER', '&&account_name'),
               'CREATE USER', 'ALTER USER')
FROM   dual;

UNDEFINE account_name
