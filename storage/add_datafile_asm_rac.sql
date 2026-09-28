------------------------------------------------------------------------------
-- Script    : storage/add_datafile_asm_rac.sql
-- Purpose   : Add a datafile to a tablespace on ASM storage in a RAC database.
-- Usage     : sqlplus / as sysdba @storage/add_datafile_asm_rac.sql
-- Requires  : SYSDBA, or ALTER TABLESPACE on the target tablespace
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Adds permanent storage. Confirm free space in the ASM disk
--             group first.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- Current size and free space of the disk group, before adding anything.
SELECT name, total_mb, free_mb, ROUND(free_mb/total_mb*100) AS pct_free
FROM   v$asm_diskgroup;

-- Add the datafile. On ASM only the disk group name is given; Oracle
-- generates the file name inside it.
ALTER TABLESPACE &&tablespace_name
  ADD DATAFILE '+&&diskgroup_name' SIZE 10G AUTOEXTEND ON NEXT 1G MAXSIZE 31G;

-- Confirm the new file.
SELECT file_name, bytes/1024/1024/1024 AS size_gb, autoextensible
FROM   dba_data_files
WHERE  tablespace_name = UPPER('&&tablespace_name');

UNDEFINE tablespace_name
UNDEFINE diskgroup_name
