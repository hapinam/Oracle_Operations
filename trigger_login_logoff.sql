Drop table security_user_log;
------------------------------------------------------------------------------------------------------------
create table
   security_user_log
(
   user_id           varchar2(30),
   session_id        number(10),
   host              varchar2(30),
   domain_user		 varchar2(30),
   last_program      varchar2(48),
   last_action       varchar2(32),
   last_statement	 varchar2(1000),
   last_module       varchar2(32),
   logon_day         date,
   logon_time        varchar2(15),
   logoff_day        date,
   logoff_time       varchar2(15),
   elapsed_minutes   number(8)
);
------------------------------------------------------------------------------------------------------------
create or replace trigger
   logon_audit_trigger
AFTER LOGON ON DATABASE
BEGIN
if upper(user) not IN ('SYS' , 'SYSTEM' , 'DBSNMP' , 'SYSMAN') then
insert into security_user_log values(
   user,
   sys_context('USERENV','SESSIONID'),
   sys_context('USERENV','HOST'),
   sys_context('USERENV','OS_USER'),
   null,
   null,
   null,
   null,
   sysdate,
   to_char(sysdate, 'hh:mi:ss AM'),
   null,
   null,
   null
);
end if;
END;
------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER logoff_audit_trigger
BEFORE LOGOFF ON DATABASE
BEGIN
if upper(user) not IN ('SYS' , 'SYSTEM' , 'DBSNMP' , 'SYSMAN') then
update security_user_log
set 
last_action = sys_context('USERENV','action'),
last_module = sys_context('USERENV','module'),
last_program = (select program from v$session where sys_context('USERENV','SESSIONID') = audsid),
last_statement = (select * from(SELECT S.SQL_ID FROM V_$SQL S, ALL_USERS U, V$SESSION SN WHERE S.PARSING_USER_ID=U.USER_ID AND UPPER(U.USERNAME)=user AND S.SQL_ID=SN.SQL_ID(+) order by S.LAST_LOAD_TIME desc)where rownum=1),
logoff_day = sysdate,
logoff_time = to_char(sysdate, 'hh:mi:ss AM')
where sys_context('USERENV','SESSIONID') = session_id;
------------------------------------------------------------------------------------------------------------
update security_user_log
set elapsed_minutes = round((logoff_day - logon_day)*1440,2)
where sys_context('USERENV','SESSIONID') = session_id;
end if;
END;
------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FORCE VIEW LOGON_LOGOFF_USER_VIEW
(
   USER_ID,
   SESSION_ID,
   HOST,
   DOMAIN_USER,
   LOGON_TIME,
   LOGOFF_TIME,
   LOGON_DAY,
   LOGOFF_DAY,
   ELAPSED_MINUTES,
   LAST_ACTION,
   LAST_MODULE,
   LAST_PROGRAM,
   SQL_TEXT
)
   BEQUEATH DEFINER
AS
     SELECT S.USER_ID,
            S.SESSION_ID,
            S.HOST,
            S.DOMAIN_USER,
            S.LOGON_TIME,
            S.LOGOFF_TIME,
            S.LOGON_DAY,
            S.LOGOFF_DAY,
            S.ELAPSED_MINUTES,
            S.LAST_ACTION,
            S.LAST_MODULE,
            S.LAST_PROGRAM,
            Q.SQL_TEXT
       FROM SECURITY_USER_LOG s, v$sql q
      WHERE Q.SQL_ID(+) = S.LAST_STATEMENT
   ORDER BY S.USER_ID;
------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PUBLIC SYNONYM LOGON_LOGOFF_USER_VIEW FOR SYS.LOGON_LOGOFF_USER_VIEW;
------------------------------------------------------------------------------------------------------------