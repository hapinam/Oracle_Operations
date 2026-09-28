------------------------------------------------------------------------------
-- Script    : objects/index_rebuild_parallel.sql
-- Purpose   : Generate parallel, online rebuild statements for the large
--             indexes of a schema, to speed up bulk index maintenance.
-- Usage     : sqlplus / as sysdba @objects/index_rebuild_parallel.sql
-- Requires  : ALTER ANY INDEX, or ownership of the index
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : A parallel rebuild leaves the index with a parallel degree;
--             reset it afterwards with objects/index_set_noparallel.sql.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- Generate a parallel, online rebuild for every index on a table larger than
-- 10 GB in the given schema. Review the output before running it, and reset
-- the parallel degree afterwards with objects/index_reset_parallelism.sql.
SELECT 'alter index '||i.owner||'.'||i.index_name
       ||' rebuild online parallel 16 nologging;' AS stmt
FROM   dba_indexes i,
       (SELECT segment_name, SUM(bytes) AS byte
        FROM   dba_segments
        GROUP  BY segment_name) s
WHERE  i.owner = UPPER('&&index_owner')
AND    s.segment_name = i.table_name
AND    s.byte/1024/1024/1024 >= 10
AND    i.owner NOT IN ('SYS','SYSTEM');

UNDEFINE index_owner
