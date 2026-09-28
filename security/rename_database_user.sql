------------------------------------------------------------------------------
-- Script    : security/rename_database_user.sql
-- Purpose   : Rename a database account by updating the data dictionary
--             directly.
-- Usage     : sqlplus / as sysdba @security/rename_database_user.sql
-- Requires  : SYSDBA, with the database in restricted mode
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Updating SYS.USER$ is not supported by Oracle and can corrupt
--             the dictionary. The supported alternative is to create a new
--             user and move the objects with Data Pump. Kept for reference
--             only.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

CONN / AS SYSDBA

UPDATE USER$ SET NAME='NEW NAME' WHERE NAME='OLD NAME';
COMMIT;

SHUTD IMMEDIATE;
STARTUP;
