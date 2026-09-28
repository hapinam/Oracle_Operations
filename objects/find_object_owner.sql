------------------------------------------------------------------------------
-- Script    : objects/find_object_owner.sql
-- Purpose   : Find which schema owns an object when only the object name is
--             known.
-- Usage     : sqlplus / as sysdba @objects/find_object_owner.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- Find an object when only part of its name is known.
SELECT owner, object_name, object_type, status, created, last_ddl_time
FROM   all_objects
WHERE  LOWER(object_name) LIKE LOWER('%&&object_name%')
ORDER  BY owner, object_type, object_name;

UNDEFINE object_name
