2189854.1

open ports of xdisplay
create a new Oracle home 12c and increase /Oracle file system 


create pfile without any # and without local_listener parameters and startup source DB with updated pfile

Patch 29213893 on target
Patch latest psu on target


SQL> exec DBMS_STATS.GATHER_DATABASE_STATS(DEGREE => 16,cascade => true);
SQL> exec DBMS_STATS.GATHER_DICTIONARY_STATS (DEGREE => 16);
SQL> exec DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;
SQL> PURGE DBA_RECYCLEBIN;
SQL> @?/rdbms/admin/utlrp.sql
---SQL> @?/rdbms/admin/catalog.sql
---SQL> @?/rdbms/admin/catproc.sql

select * from dba_objects where status='INVALID';
select count(*),owner from dba_objects where status <> 'VALID' group by owner;


  COUNT(*) OWNER
---------- ------------------------------
         4 DMSYS


select * from dba_registry;

change sys password and gather statistics and count invalid objects
make system,sysaux,users tablespaces autoextend

Create restore point before upgrade.

CONN / AS SYSDBA
ALTER SYSTEM SET log_archive_dest_1='location=/databck/archivelogs' SCOPE=SPFILE;
ALTER SYSTEM SET log_archive_format='ARC%S_%R.%T' SCOPE=SPFILE;
ALTER SYSTEM SET DB_RECOVERY_FILE_DEST_SIZE=1000G SCOPE=BOTH;
SHUTDOWN IMMEDIATE
STARTUP MOUNT
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;

ALTER DATABASE FLASHBACK ON;
CREATE RESTORE POINT before_upgrade GUARANTEE FLASHBACK DATABASE;



delete listener on old home and create new one on new home (netca of new home)
export ORACLE_HOME=/oracle/product/12.2.0
export PATH=$PATH:$ORACLE_HOME
cd /oracle/product/12.2.0/bin
./dbua

SELECT version FROM v$timezone_file;   -- 26
exec DBMS_STATS.GATHER_DATABASE_STATS (cascade => TRUE,DEGREE => 12);
exec DBMS_STATS.GATHER_DICTIONARY_STATS (DEGREE => 12);
exec DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;

copy tnsnames from 11g home to new 12c home
CONN / AS SYSDBA
DROP RESTORE POINT before_upgrade;
ALTER DATABASE FLASHBACK OFF;
SHUTDOWN IMMEDIATE
STARTUP MOUNT
ALTER DATABASE NOARCHIVELOG;
ALTER DATABASE OPEN;

