Upgrade DB

1- SELECT count (*), owner FROM dba_objects where status= 'INVALID' group by owner;


  COUNT(*) OWNER
---------- ------------------------------
        40 DB

		
		
2-	Copy pre upgrade utility: utlu112i.sql   from /oracle/product/11.2.0/db_1/rdbms/admin to /oracle and give privilege to oracle to write on it.

cp /oracle/product/11.2.0/db_1/rdbms/admin/utlu112i.sql /oracle

chmod 775 /oracle/utlu112i.sql


3- Copy initdb.ora to new home under same path and apply the Changes:

cp /oracle/product/10.2.0/db_1/dbs/initdb.ora  /oracle/product/11.2.0/db_1/dbs

#audit_file_dest='/oracle/product/11.2.0/db_1/admin/db/adump'
audit_file_dest='/oracle/diag/audit'
#background_dump_dest='/oracle/product/10.2.0/db_1/admin/db/bdump'
compatible='10.2.0.3.0'
#compatible='11.2.0.4.0'

#control_files='/oradata/db/control01.ctl','/oradata/db/control02.ctl','/oracle/product/10.2.0/db_1/dbs/control03.ctl'

control_files='/oradata/db/control01.ctl','/oradata/db/control02.ctl','/oradata/db/control03.ctl'
#core_dump_dest='/oracle/product/10.2.0/db_1/admin/db/cdump'
db_block_size=8192
db_domain=''
db_file_multiblock_read_count=16
db_name='db'
dispatchers='(PROTOCOL=TCP) (SERVICE=dbXDB)'
job_queue_processes=100
open_cursors=300
pga_aggregate_target=1659895808
processes=500
remote_login_passwordfile='NONE'
sessions=500
sga_target=1610612736
undo_management='AUTO'
undo_tablespace='UNDOTBS1'
diagnostic_dest='/oracle/diag'
#user_dump_dest='/oracle/product/10.2.0/db_1/admin/db/udump'
log_archive_format=arch%t%s%r.ora
log_archive_max_processes=2
log_archive_dest_1='LOCATION=/databack/archivelogs'
###############################################
RECYCLEBIN=OFF
#_kghdsidx_count=1
###############################################


4-	Shutdown the database (Begin of downtime)
5-	Update the environment variables to new home in /home/oracle/.bash_profile
6-	exit and su – oracle again to apply changes in environment variables
7-	cd $ORACLE_HOME/rdbms/admin
8-	startup upgrade
9-	@catupgrd.sql 
10-	Startup database
11-	Check the alert log
12-	
Run utlu112s.sql to check components 
19-	
Run catuppst.sql
20-
Run select ACTION_TIME,BUNDLE_SERIES,ID,COMMENTS from dba_registry_history where ACTION='APPLY' and ID<>0 ;
21-	
Run utlrp.sql (2 times)
22-	Check count of invalid objects
SELECT count (*), owner FROM dba_objects where status= 'INVALID' group by owner;
