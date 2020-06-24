select substr(index_owner,1,10) "owner",
substr(index_name,1,20) "partitioned index",
substr(partition_name,1,10) "partition name",
substr(tablespace_name,1,15) "tablespace name"
from dba_ind_partitions
where status in ('UNUSABLE','UNVISIBLE')
order by index_name;
