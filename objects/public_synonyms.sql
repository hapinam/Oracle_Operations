------------------------------------------------------------------------------
-- Script    : objects/public_synonyms.sql
-- Purpose   : List public synonyms and generate the statements to recreate
--             or drop them.
-- Usage     : sqlplus / as sysdba @objects/public_synonyms.sql
-- Requires  : SELECT_CATALOG_ROLE, CREATE/DROP PUBLIC SYNONYM to apply
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Dropping a public synonym breaks every application that relies
--             on the unqualified name.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- Public synonyms, optionally narrowed to the schema they point at.
SELECT synonym_name, table_owner, table_name, db_link
FROM   dba_synonyms
WHERE  owner = 'PUBLIC'
AND    table_owner LIKE UPPER('&&object_owner')
ORDER  BY synonym_name;

-- Generate the statements to recreate them elsewhere.
SELECT 'create or replace public synonym '||synonym_name
       ||' for '||table_owner||'.'||table_name||';' AS stmt
FROM   dba_synonyms
WHERE  owner = 'PUBLIC'
AND    table_owner LIKE UPPER('&&object_owner');

-- Generate the statements to drop them.
-- SELECT 'drop public synonym '||synonym_name||';'
-- FROM   dba_synonyms
-- WHERE  owner = 'PUBLIC' AND table_owner LIKE UPPER('&&object_owner');

UNDEFINE object_owner
