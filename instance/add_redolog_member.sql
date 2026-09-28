------------------------------------------------------------------------------
-- Script    : instance/add_redolog_member.sql
-- Purpose   : Add a member to an existing online redo log group and drop a
--             member that is no longer needed.
-- Usage     : sqlplus / as sysdba @instance/add_redolog_member.sql
-- Requires  : SYSDBA
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Dropping a redo log member removes the file from the file
--             system. Never drop the last member of a group.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

sql>select group#,archived,status from v$log

sql>ALTER DATABASE ADD LOGFILE MEMBER 'D:\oracle\product\10.2.0\oradata\orcl\redo04b.log' TO GROUP 3;
sql>ALTER DATABASE ADD LOGFILE GROUP 4 ('/redo1/oradata/redo04a.log','/redo1/oradata/redo04b.log') SIZE 200M
sql>ALTER DATABASE DROP LOGFILE GROUP 1



----------------
select * from v$log
ALTER DATABASE ADD LOGFILE THREAD 1 GROUP 2 ('+REDO1/redo02a.log','+REDO2/redo02b.log') SIZE 10G
ALTER DATABASE DROP LOGFILE GROUP 2
ALTER system switch logfile;
ALTER system checkpoint;
