------------------------------------------------------------------------------
-- Script    : objects/create_database_link.sql
-- Purpose   : Create a public database link, list existing links and drop one.
-- Usage     : sqlplus / as sysdba @objects/create_database_link.sql
-- Requires  : CREATE PUBLIC DATABASE LINK, DROP PUBLIC DATABASE LINK
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : A link stores the remote password in the database. Use a
--             dedicated read-only remote account and never commit the real
--             password.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- Create the link. The remote password is stored in the database, so use a
-- dedicated, read-only remote account and supply the value at run time.
CREATE PUBLIC DATABASE LINK remote_db
  CONNECT TO remote_user
  IDENTIFIED BY "&&remote_password"
  USING 'REMOTE_TNS_ALIAS';

-- Verify the link works.
SELECT * FROM dual@remote_db;

-- List the links that already exist.
SELECT owner, db_link, username, host, created FROM dba_db_links ORDER BY owner, db_link;

-- Remove a link that is no longer needed.
-- DROP PUBLIC DATABASE LINK remote_db;

UNDEFINE remote_password
