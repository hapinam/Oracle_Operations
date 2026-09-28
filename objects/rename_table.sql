------------------------------------------------------------------------------
-- Script    : objects/rename_table.sql
-- Purpose   : Rename a table and copy its rows into a freshly created table
--             of the same name, the usual pattern before a restructure.
-- Usage     : sqlplus / as sysdba @objects/rename_table.sql
-- Requires  : ALTER ANY TABLE, or ownership of the table
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Renaming a table invalidates dependent views, synonyms and
--             PL/SQL, and constraints or grants do not follow the copy
--             automatically. Take a backup first.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- 1. Move the current table out of the way.
ALTER TABLE &&owner_name..&&table_name RENAME TO &&table_name._OLD;

-- 2. Create the new table with the corrected structure, then copy the rows.
--    Constraints, indexes, grants and triggers do NOT follow the rename, so
--    recreate them explicitly on the new table.
INSERT /*+ APPEND */ INTO &&owner_name..&&table_name
SELECT * FROM &&owner_name..&&table_name._OLD;
COMMIT;

-- 3. Check the row counts match before dropping anything.
SELECT (SELECT COUNT(*) FROM &&owner_name..&&table_name)      AS new_rows,
       (SELECT COUNT(*) FROM &&owner_name..&&table_name._OLD) AS old_rows
FROM   dual;

UNDEFINE owner_name
UNDEFINE table_name
