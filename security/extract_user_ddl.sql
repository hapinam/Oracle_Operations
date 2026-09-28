------------------------------------------------------------------------------
-- Script    : security/extract_user_ddl.sql
-- Purpose   : Extract the CREATE USER and GRANT statements for an existing
--             user with DBMS_METADATA so the account can be recreated on
--             another database.
-- Usage     : sqlplus / as sysdba @security/extract_user_ddl.sql
-- Requires  : SELECT_CATALOG_ROLE plus EXECUTE on DBMS_METADATA
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : The generated DDL contains the password verifier of the user.
--             Treat the output as a credential and do not store it in
--             version control.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- Full account DDL, including the password verifier, default tablespace,
-- profile and quotas.
SELECT dbms_metadata.get_ddl('USER', UPPER('&&account_name')) FROM dual;

-- Roles, system privileges and object privileges granted to the account.
SELECT dbms_metadata.get_granted_ddl('ROLE_GRANT',        UPPER('&&account_name')) FROM dual;
SELECT dbms_metadata.get_granted_ddl('SYSTEM_GRANT',      UPPER('&&account_name')) FROM dual;
SELECT dbms_metadata.get_granted_ddl('OBJECT_GRANT',      UPPER('&&account_name')) FROM dual;
SELECT dbms_metadata.get_granted_ddl('TABLESPACE_QUOTA',  UPPER('&&account_name')) FROM dual;

UNDEFINE account_name
