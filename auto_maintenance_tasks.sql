--disable autotask
exec dbms_auto_task_admin.disable;

EXEC DBMS_AUTO_TASK_ADMIN.DISABLE ('AUTO OPTIMIZER STATS COLLECTION', NULL, NULL);
EXEC DBMS_AUTO_TASK_ADMIN.DISABLE ('AUTO SPACE ADVISOR', NULL, NULL);
exec dbms_auto_task_admin.disable('sql tuning advisor',NULL,NULL);

BEGIN
dbms_auto_task_admin.disable(
client_name => 'sql tuning advisor',
operation => NULL,
window_name => NULL);
END;

begin dbms_auto_task_admin.disable( client_name=>'auto optimizer stats collection', operation=>null, window_name=>null); end;



--enable autotask
exec dbms_auto_task_admin.enable;


--------------------------------------

select
   window_name, 
   autotask_status 
from 
   dba_autotask_window_clients;


select * from  DBA_AUTOTASK_OPERATION ;

select * from DBA_SCHEDULER_WINDOWS;


--------------------------------------


exec dbms_scheduler.disable ('sys.SATURDAY_WINDOW');
exec dbms_scheduler.disable ('sys.SUNDAY_WINDOW');
exec dbms_scheduler.disable ('sys.MONDAY_WINDOW');
exec dbms_scheduler.disable ('sys.TUESDAY_WINDOW');
exec dbms_scheduler.disable ('sys.WEDNESDAY_WINDOW');
exec dbms_scheduler.disable ('sys.THURSDAY_WINDOW');
exec dbms_scheduler.disable ('sys.FRIDAY_WINDOW');


----------------------------------

Views:

  dba_autotask_task: This view shows information about task execution time, current status, priority and historical data like last and best times

  dba_autotask_window_clients:  This view displays information about current windows available in the database belonging to maintenance_window_group

  dba_autotask_client_history:  View used to show historical information for each job execution

  dba_autotask_operation:  View used to display operation information for each client, such as attributes and status

  dba_autotask_job_history: This view provides information about job runs after each execution

  dba_autotask_client:  View used to display statistical data for each task for the last seven days. It also shows an evaluation for the last 30 days.

  dba_autotask_window_history:  Shows historical information for each maintenance task window


-----------------------------------------------

SCHEDULER[0x2C59]:DEFAULT_MAINTENANCE_PLAN

-----------------------------------------------

10g:


SELECT 
   * -- state
FROM 
   DBA_SCHEDULER_JOBS 
--WHERE JOB_NAME = 'GATHER_STATS_JOB';


exec dbms_scheduler.disable('SYS.GATHER_STATS_JOB');