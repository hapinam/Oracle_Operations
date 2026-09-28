------------------------------------------------------------------------------
-- Script    : recovery/flashback_database.sql
-- Purpose   : Create a guaranteed restore point, check flashback retention,
--             and flash the database back to that point.
-- Usage     : sqlplus / as sysdba @recovery/flashback_database.sql
-- Requires  : SYSDBA, database in ARCHIVELOG mode with flashback enabled
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : FLASHBACK DATABASE discards every change made after the
--             restore point and requires the database to be mounted. Data
--             loss is intended and irreversible once the database is opened
--             with RESETLOGS.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE FLASHBACK ON;
ALTER SYSTEM SET DB_FLASHBACK_RETENTION_TARGET=4320; # 3 days


FLASHBACK DATABASE TO TIMESTAMP TO_TIMESTAMP ('2015-04-27 14:30:00','YYYY-MM-DD HH24:MI:SS');


SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
FLASHBACK DATABASE TO RESTORE POINT RESTORE_16OCT18;
ALTER DATABASE OPEN RESETLOGS;
ALTER DATABASE FLASHBACK OFF;

alter database noarchivelog;
select * from v$restore_point;
drop restore point B4_TEST;

rman target / nocatalog
RMAN> delete noprompt archivelog all;

-------------------------------------------------------------------------------------------------------------------
Flashback table:
----------------

create table bank_bak.test_users(id number) tablespace users;

insert into bank_bak.test_users values(1);
insert into bank_bak.test_users values(2);
insert into bank_bak.test_users values(3);


select * from bank_bak.test_users

commit;

select sysdate from dual;

insert into bank_bak.test_users values(4);

commit;

ALTER TABLE  bank_bak.test_users  ENABLE ROW MOVEMENT;

FLASHBACK TABLE bank_bak.test_users  TO TIMESTAMP TO_TIMESTAMP('2019-01-13 09:30:00','YYYY-MM-DD HH24:MI:SS');
--FLASHBACK TABLE bank_bak.test_users  TO TIMESTAMP (SYSTIMESTAMP - INTERVAL '1' minute);
