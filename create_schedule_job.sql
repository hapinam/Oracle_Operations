BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'OWNER.XX_DAILY_REGISTER_JOB'
      ,start_date      => TO_TIMESTAMP_TZ('2017/08/08 10:29:10.622000 +02:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=daily; byhour=0; byminute=15; bysecond=0;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN XX_A_DAILY_REGISTER(); end;'
      ,comments        => 'Job Daily Register'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'OWNER.XX_A_DAILY_REGISTER_JOB'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'OWNER.XX_A_DAILY_REGISTER_JOB'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_RUNS);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'OWNER.XX_A_DAILY_REGISTER_JOB'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'OWNER.XX_A_DAILY_REGISTER_JOB'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'OWNER.XX_A_DAILY_REGISTER_JOB'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'OWNER.XX_A_DAILY_REGISTER_JOB'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'OWNER.XX_A_DAILY_REGISTER_JOB'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'OWNER.XX_A_DAILY_REGISTER_JOB'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name       => 'OWNER.XX_A_DAILY_REGISTER_JOB');
END;
/
