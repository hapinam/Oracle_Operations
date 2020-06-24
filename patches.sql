PSU /RSU and CPU Note Database 2118136.2

PSU /RSU and CPU Note Weblogic 1470197.1


@?/rdbms/admin/catbundle.sql psu apply

/usr/sbin/slibclean

11g
select ACTION_TIME,ACTION,BUNDLE_SERIES,ID,COMMENTS from dba_registry_history where ACTION ='APPLY' and ID<>0 order by 1 desc;
select ACTION_TIME,ACTION,BUNDLE_SERIES,ID,COMMENTS from dba_registry_history where ACTION !='APPLY' and ID<>0 order by 1 desc;

12c
select ACTION_TIME,BUNDLE_SERIES,patch_ID,description,BUNDLE_id,action,status from DBA_REGISTRY_SQLPATCH where ACTION='APPLY' and install_ID<>0 and status = 'SUCCESS' order by 1 desc;


export PATH=$PATH:/usr/ccs/bin
export PATH=$PATH:ORACLE_HOME/OPatch
opatch version  ( make sure from OPatch version )
lsnrctl stop
SQL> shu immediate
/usr/sbin/slibclean (AIX Only)
cd $ORACLE_HOME/bin (Linux Only)
touch fuser			(Linux Only)
chmod 755 fuser		(Linux Only)

unzip p29314339_122010_Linux-x86-64.zip
cd 29314339
opatch prereq CheckConflictAgainstOHWithDetail -ph ./
opatch apply

sqlplus / as sysdba
SQL> STARTUP
SQL> exit
cd $ORACLE_HOME/OPatch
./datapatch -verbose