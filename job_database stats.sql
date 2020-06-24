EXEC DBMS_SCHEDULER.DROP_JOB ('RBM_STATS')

BEGIN
sys.dbms_scheduler.create_job( 
job_name => '"SYS"."RBM_STATS"',
job_type => 'PLSQL_BLOCK',
job_action => 'begin
   dbms_stats.gather_database_stats( cascade => TRUE,degree=> 16,gather_sys=>TRUE,estimate_percent=> 1 ) ;
end;',
start_date => systimestamp at time zone '+2:00',
job_class => '"DEFAULT_JOB_CLASS"',
auto_drop => FALSE,
enabled => TRUE);
sys.dbms_scheduler.set_attribute( name => '"SYS"."RBM_STATS"', attribute => 'raise_events', value => dbms_scheduler.job_started + dbms_scheduler.job_succeeded + dbms_scheduler.job_failed + dbms_scheduler.job_completed + dbms_scheduler.job_stopped); 
sys.dbms_scheduler.enable( '"SYS"."RBM_STATS"' ); 
END;



---------------------


BEGIN
sys.dbms_scheduler.create_job( 
job_name => '"SYS"."REF_GATHER_STATS"',
job_type => 'PLSQL_BLOCK',
job_action => 'begin
   dbms_stats.gather_database_stats( cascade => TRUE,degree=> 16,gather_sys=>TRUE,method_opt=> ''FOR ALL COLUMNS SIZE 1'' ) ;
end;',
repeat_interval => 'FREQ=DAILY;BYHOUR=1;BYMINUTE=0;BYSECOND=0',
start_date => systimestamp at time zone 'Africa/Cairo',
job_class => '"DEFAULT_JOB_CLASS"',
auto_drop => FALSE,
enabled => FALSE);
sys.dbms_scheduler.set_attribute( name => '"SYS"."REF_GATHER_STATS"', attribute => 'raise_events', value => dbms_scheduler.job_started + dbms_scheduler.job_succeeded + dbms_scheduler.job_failed + dbms_scheduler.job_completed + dbms_scheduler.job_stopped); 
sys.dbms_scheduler.enable( '"SYS"."REF_GATHER_STATS"' ); 
END;


----------------------


BEGIN
sys.dbms_scheduler.create_job( 
job_name => '"SYS"."RBM_GATHER_STATS"',
job_type => 'PLSQL_BLOCK',
job_action => 'begin
   dbms_stats.gather_database_stats( cascade => TRUE,degree=> 16,gather_sys=>TRUE,method_opt=> ''FOR ALL COLUMNS SIZE 1'' ) ;
end;',
repeat_interval => 'FREQ=WEEKLY;BYDAY=FRI;BYHOUR=05;BYMINUTE=0;BYSECOND=0',
start_date => to_timestamp_tz('2017-07-28 Africa/Cairo', 'YYYY-MM-DD TZR'),
job_class => '"DEFAULT_JOB_CLASS"',
auto_drop => FALSE,
enabled => TRUE);
sys.dbms_scheduler.set_attribute( name => '"SYS"."RBM_GATHER_STATS"', attribute => 'raise_events', value => dbms_scheduler.job_started + dbms_scheduler.job_succeeded + dbms_scheduler.job_failed + dbms_scheduler.job_completed + dbms_scheduler.job_stopped); 
sys.dbms_scheduler.enable( '"SYS"."RBM_GATHER_STATS"' ); 
END;



