------------------------------------------------------------------------------
-- Script    : objects/index_reset_parallelism.sql
-- Purpose   : Reset the degree of parallelism on indexes back to NOPARALLEL
--             after a parallel rebuild, for one index or for every large
--             index of a schema.
-- Usage     : sqlplus / as sysdba @objects/index_reset_parallelism.sql
-- Requires  : ALTER ANY INDEX, or ownership of the index
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : An index left with a parallel degree makes every query that
--             uses it run in parallel, which can flood the server with
--             parallel slaves. Always reset it after a parallel rebuild.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- 1. A single index.
ALTER INDEX &&index_owner..&&index_name NOPARALLEL;

-- 2. Generate the statements for every index on a table larger than 10 GB in
--    the given schema. Review the output, then run it.
SELECT 'alter index '||i.owner||'.'||i.index_name||' noparallel;' AS stmt
FROM   dba_indexes i,
       (SELECT segment_name, SUM(bytes) AS byte
        FROM   dba_segments
        GROUP  BY segment_name) s
WHERE  i.owner = UPPER('&&index_owner')
AND    s.segment_name = i.table_name
AND    s.byte/1024/1024/1024 >= 10
AND    i.owner NOT IN ('SYS','SYSTEM');

-- 3. Confirm nothing is left parallel.
SELECT owner, index_name, degree
FROM   dba_indexes
WHERE  owner = UPPER('&&index_owner')
AND    TRIM(degree) NOT IN ('1','DEFAULT');

UNDEFINE index_owner
UNDEFINE index_name
