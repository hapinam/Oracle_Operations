------------------------------------------------------------------------------
-- Script    : security/user_password_expiry.sql
-- Purpose   : Check when an account's password expires, and restore a
--             previous password from its stored verifier after a temporary
--             change.
-- Usage     : sqlplus / as sysdba @security/user_password_expiry.sql
-- Requires  : SYSDBA (SYS.USER$ is not exposed to ordinary DBA accounts)
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : The verifier read below IS the password credential. Never
--             paste real output into a ticket, an email or a repository,
--             and clear your terminal scrollback afterwards.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- 1. When does the password expire, and which profile drives that?
SELECT username, account_status, expiry_date, profile
FROM   dba_users
WHERE  username = '&&account_name';

-- 2. Read the current verifier so the password can be put back later.
--    11g and later store it in SPARE4; PASSWORD holds the 10g verifier.
SELECT name, password, spare4
FROM   sys.user$
WHERE  name = '&&account_name';

-- 3. Optional: move the account to a profile without password expiry.
-- ALTER USER &&account_name PROFILE default;

-- 4. Restore the previous password from the verifier captured in step 2.
--    Substitute the value you read; do not store a real verifier here.
-- ALTER USER &&account_name IDENTIFIED BY VALUES '<password_verifier>';

UNDEFINE account_name
