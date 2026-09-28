------------------------------------------------------------------------------
-- Script    : jobs/enable_disable_autotask.sql
-- Purpose   : Enable or disable the automated maintenance tasks such as the
--             automatic optimizer statistics job.
-- Usage     : sqlplus / as sysdba @jobs/enable_disable_autotask.sql
-- Requires  : SYSDBA (EXECUTE on DBMS_AUTO_TASK_ADMIN)
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Disabling the statistics task means optimizer statistics stop
--             being refreshed; schedule your own job instead.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

EXEC dbms_auto_task_admin.disable( 'auto space advisor', NULL, NULL );
EXEC dbms_auto_task_admin.disable( 'sql tuning advisor', NULL, NULL );
EXEC dbms_auto_task_admin.disable( 'auto optimizer stats collection', NULL, NULL );

EXEC dbms_auto_task_admin.enable( 'auto space advisor', NULL, NULL );
EXEC dbms_auto_task_admin.enable( 'sql tuning advisor', NULL, NULL );
EXEC dbms_auto_task_admin.enable( 'auto optimizer stats collection', NULL, NULL );
