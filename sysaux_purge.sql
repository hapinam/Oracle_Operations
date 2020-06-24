##check the current sysaux size and in which objects:
------------------------------------------------------
SELECT occupant_desc,occupant_name, round( space_usage_kbytes/1024) "Space (M)", schema_name, move_procedure 
FROM v$sysaux_occupants 
ORDER BY 2 desc

---------------------------------------------------------------------------------------------------------------------

SELECT snap_id, begin_interval_time, end_interval_time 
FROM SYS.WRM$_SNAPSHOT 
WHERE snap_id = ( SELECT MIN (snap_id) FROM SYS.WRM$_SNAPSHOT)
UNION 
SELECT snap_id, begin_interval_time, end_interval_time 
FROM SYS.WRM$_SNAPSHOT 
WHERE snap_id = ( SELECT MAX (snap_id) FROM SYS.WRM$_SNAPSHOT)

---------------------------------------------------------------------------------------------------------------------

BEGIN                                                               
  dbms_workload_repository.drop_snapshot_range(low_snap_id =>6913, high_snap_id=>7113);                                         
END;


---------------------------------------------------------------------------------------------------------------------

exec DBMS_STATS.PURGE_STATS(SYSDATE-8);


---------------------------------------------------------------------------------------------------------------------


##See the oldest statistics history available:
-----------------------------------------------
SQL> SELECT DBMS_STATS.GET_STATS_HISTORY_AVAILABILITY FROM DUAL;



##See the stats retention ( days ):
------------------------------------
SQL> select dbms_stats.get_stats_history_retention from dual;


##Modify retention:
--------------------
SQL> exec DBMS_STATS.ALTER_STATS_HISTORY_RETENTION(60);




##Space currently used to store statistics in SYSAUX in KBytes, so increasing the retention would affect it’s size:
--------------------------------------------------------------------------------------------------------------------
SQL> select occupant_desc, space_usage_kbytes from v$sysaux_occupants where OCCUPANT_DESC like '%Statistics%';




##Purge stats:
--------------
SQL> exec DBMS_STATS.PURGE_STATS(DBMS_STATS.PURGE_ALL);



##Unified Audit:
-----------------


##Delete before sprecific date ( will use delete statement ):
-----------------------------------------------------------------------------

BEGIN
  DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(
   AUDIT_TRAIL_TYPE     =>  DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
   LAST_ARCHIVE_TIME    =>  '31-JAN-2020 01:00:00.00',
   RAC_INSTANCE_NUMBER  =>  1,
   CONTAINER            => DBMS_AUDIT_MGMT.CONTAINER_CURRENT);
END;
/

BEGIN
DBMS_AUDIT_MGMT.CLEAN_AUDIT_TRAIL(
audit_trail_type         =>  DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
use_last_arch_timestamp  =>  TRUE);
END;
/



-----------------------------------------------------------------------------------------------------------------------------
###Purge all ( will drop partitions and reclaim space ):
-------------------------------------------------------------------

BEGIN
DBMS_AUDIT_MGMT.CLEAN_AUDIT_TRAIL(
audit_trail_type         =>  DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
use_last_arch_timestamp  =>  FALSE);
END;
/

