EXEC dbms_auto_task_admin.disable( 'auto space advisor', NULL, NULL );
EXEC dbms_auto_task_admin.disable( 'sql tuning advisor', NULL, NULL );
EXEC dbms_auto_task_admin.disable( 'auto optimizer stats collection', NULL, NULL );

EXEC dbms_auto_task_admin.enable( 'auto space advisor', NULL, NULL );
EXEC dbms_auto_task_admin.enable( 'sql tuning advisor', NULL, NULL );
EXEC dbms_auto_task_admin.enable( 'auto optimizer stats collection', NULL, NULL );