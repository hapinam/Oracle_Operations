------------------------------------------------------------------------------
-- Script    : instance/recreate_redolog_groups.sql
-- Purpose   : Add online and standby redo log groups, switch away from the
--             old ones and drop them, the normal way to resize redo.
-- Usage     : sqlplus / as sysdba @instance/recreate_redolog_groups.sql
-- Requires  : SYSDBA
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : You can only drop a redo log group that is INACTIVE and
--             archived. Dropping the wrong group, or the physical files of a
--             current group, can make the database unrecoverable.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

ALTER DATABASE DROP LOGFILE GROUP 1;
ALTER DATABASE DROP LOGFILE GROUP 2;
ALTER DATABASE DROP LOGFILE GROUP 3;
ALTER DATABASE ADD LOGFILE GROUP 1 ('/u01/app/oracle/oralogs/orcl/redo01.log', '/u01/app/oracle/oralogs/orcl/redo11.log') size 1g reuse;
ALTER DATABASE ADD LOGFILE GROUP 2 ('/u01/app/oracle/oralogs/orcl/redo02.log', '/u01/app/oracle/oralogs/orcl/redo22.log') size 1g reuse;
ALTER DATABASE ADD LOGFILE GROUP 3 ('/u01/app/oracle/oralogs/orcl/redo03.log', '/u01/app/oracle/oralogs/orcl/redo33.log') size 1g reuse;

ALTER DATABASE DROP STANDBY LOGFILE GROUP 4;
ALTER DATABASE DROP STANDBY LOGFILE GROUP 5;
ALTER DATABASE DROP STANDBY LOGFILE GROUP 6;
ALTER DATABASE ADD STANDBY LOGFILE GROUP 4 ('/u01/app/oracle/oralogs/orcl/redo04.log', '/u01/app/oracle/oralogs/orcl/redo44.log') size 1g reuse;
ALTER DATABASE ADD STANDBY LOGFILE GROUP 5 ('/u01/app/oracle/oralogs/orcl/redo05.log', '/u01/app/oracle/oralogs/orcl/redo55.log') size 1g reuse;
ALTER DATABASE ADD STANDBY LOGFILE GROUP 6 ('/u01/app/oracle/oralogs/orcl/redo06.log', '/u01/app/oracle/oralogs/orcl/redo66.log') size 1g reuse;
