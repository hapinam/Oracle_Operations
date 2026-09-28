------------------------------------------------------------------------------
-- Script    : storage/move_table_and_index.sql
-- Purpose   : Move a table to another tablespace and rebuild its indexes
--             there.
-- Usage     : sqlplus / as sysdba @storage/move_table_and_index.sql
-- Requires  : ALTER ANY TABLE and ALTER ANY INDEX, or ownership of the objects
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : A non online MOVE locks the table and leaves its indexes
--             UNUSABLE until they are rebuilt. Plan an outage or use ONLINE
--             on 12c and later.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- 1. Move the table. ONLINE is available from 12cR2; without it the table is
--    locked for the duration.
ALTER TABLE &&owner_name..&&table_name MOVE TABLESPACE &&new_tablespace;

-- 2. The move leaves every index on the table UNUSABLE. Generate the
--    rebuilds, then run them.
SELECT 'alter index '||owner||'.'||index_name
       ||' rebuild tablespace &&new_tablespace online;' AS stmt
FROM   dba_indexes
WHERE  table_owner = UPPER('&&owner_name')
AND    table_name  = UPPER('&&table_name');

-- 3. Confirm nothing is left unusable.
SELECT owner, index_name, status
FROM   dba_indexes
WHERE  table_owner = UPPER('&&owner_name')
AND    table_name  = UPPER('&&table_name');

UNDEFINE owner_name
UNDEFINE table_name
UNDEFINE new_tablespace
