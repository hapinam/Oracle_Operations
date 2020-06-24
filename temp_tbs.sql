select se.username,se.sid,su.extents,su.blocks*8192/1024/1024 MB,tablespace,segtype,se.sql_id,sql_text 
from v$sort_usage su,v$session se,v$sql s
where su.session_addr=se.saddr and s.sql_id=se.sql_id order by  mb desc;


select se.username,sum(su.extents),sum(su.blocks)*8192/1024/1024 MB,tablespace,segtype,se.sql_id,sql_text 
from v$sort_usage su,v$session se,v$sql s
where su.session_addr=se.saddr and s.sql_id=se.sql_id 
group by se.username,tablespace,segtype,se.sql_id,sql_text
order by  mb desc;


SELECT A.tablespace_name tablespace, D.mb_total, SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_used, D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_free
FROM v$sort_segment A,(SELECT B.name, C.block_size, SUM (C.bytes) / 1024 / 1024 mb_total
					FROM v$tablespace B, v$tempfile C
					WHERE B.ts#= C.ts#
					GROUP BY B.name, C.block_size) D
WHERE A.tablespace_name = D.name
GROUP by A.tablespace_name, D.mb_total;