CREATE TABLE Mostafam.GROWTH_ROWS#
   (           "TABLE_NAME" VARCHAR2(20 BYTE), 
                "NUM_ROWS" NUMBER, 
                "RUN_DATE" VARCHAR2(20 BYTE) DEFAULT to_date(sysdate)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CASEMGMT_DATA01" ;



CREATE TABLE Mostafam.GROWTH_MB#
   (           "SEG_NAME" VARCHAR2(100 BYTE), 
                "SIZE_GB" NUMBER, 
                "RUN_DATE" DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CASEMGMT_DATA01" ;






-------------------------------------------------------------------------------



BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => 'mostafam.Growth_GB_Daily',
            job_type => 'PLSQL_BLOCK',
            job_action => 'begin
insert into GROWTH_MB# (SEG_NAME,Size_GB )
select t.SEGMENT_NAME , (t.BYTES / 1024 / 1024 / 1024) as GB 
from dba_SEGMENTS t 
where (t.BYTES / 1024 / 1024 / 1024)  >= 1
order by GB desc;
commit;
end;',
            number_of_arguments => 0,
            start_date => NULL,
            repeat_interval => 'FREQ=DAILY;BYTIME=010000',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => 'Monitor Growth for segements larger than 1G');

    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => 'mostafam.Growth_GB_Daily', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
  
    DBMS_SCHEDULER.enable(
             name => 'mostafam.Growth_GB_Daily');
END;




------------------------------------------------------------------------------


BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => 'mostafam.Growth_Rows_Daily',
            job_type => 'PLSQL_BLOCK',
            job_action => 'begin
insert into GROWTH_ROWS#(TABLE_NAME,NUM_ROWS)
select t.table_name, t.num_rows from dba_tables t where t.NUM_ROWS is not null
and t.NUM_ROWS > 1000000
order by t.num_rows desc;
commit;
end;',
            number_of_arguments => 0,
            start_date => NULL,
            repeat_interval => 'FREQ=DAILY;BYTIME=010500',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => 'Monitor Growth for tables more than one million rows');

    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => 'mostafam.Growth_Rows_Daily', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
  
    DBMS_SCHEDULER.enable(
             name => 'mostafam.Growth_Rows_Daily');
END;
