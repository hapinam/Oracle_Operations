select tablespace_name,status,count(*) "#Extents", round(sum(bytes)/1024/1024/1024) "Size_GB"
from dba_undo_extents
group by tablespace_name,status;


select TO_CHAR(s.sid)||','||TO_CHAR(s.serial#) sid_serial, NVL(s.username, 'None') orauser, s.program, r.name undoseg, t.used_ublk * TO_NUMBER(x.value)/1024||'K' "Undo"
from sys.v_$rollname r, sys.v_$session s, sys.v_$transaction t, sys.v_$parameter x
where s.taddr = t.addr
AND r.usn = t.xidusn(+)
AND x.name = 'db_block_size';


select s.sid, s.username, t.used_urec, t.used_ublk
from v$session s, v$transaction t
where s.saddr = t.ses_addr
order by t.used_ublk desc;