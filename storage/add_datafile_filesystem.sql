------------------------------------------------------------------------------
-- Script    : storage/add_datafile_filesystem.sql
-- Purpose   : Add a datafile to a tablespace on a file system, and resize or
--             autoextend an existing one.
-- Usage     : sqlplus / as sysdba @storage/add_datafile_filesystem.sql
-- Requires  : SYSDBA, or ALTER TABLESPACE on the target tablespace
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Adds permanent storage. Verify the mount point has free space
--             before running.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- Add a new datafile to the tablespace.
ALTER TABLESPACE &&tablespace_name
  ADD DATAFILE '&&datafile_path' SIZE 5G AUTOEXTEND OFF;

-- Or grow an existing one instead of adding a file.
-- ALTER DATABASE DATAFILE '&&datafile_path' RESIZE 10G;
-- ALTER DATABASE DATAFILE '&&datafile_path' AUTOEXTEND ON NEXT 512M MAXSIZE 31G;

-- Confirm the result.
SELECT file_name, bytes/1024/1024/1024 AS size_gb, autoextensible, maxbytes/1024/1024/1024 AS max_gb
FROM   dba_data_files
WHERE  tablespace_name = UPPER('&&tablespace_name');

UNDEFINE tablespace_name
UNDEFINE datafile_path
