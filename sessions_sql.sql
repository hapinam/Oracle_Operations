select v.sid,s.sql_id,s.cpu_time,v.module,v.program,v.terminal,v.username,v.machine,v.osuser,s.sql_text
from v$sql s, v$session v
WHERE v.sql_address=s.address 
AND v.sql_hash_value=s.hash_value
and v.status='ACTIVE' /*and sql_text like '%ALL_INSTR%'*/
order by 3 desc