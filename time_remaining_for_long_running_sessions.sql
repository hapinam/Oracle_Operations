select sid, username, opname, target, sofar, totalwork,  units, elapsed_seconds, to_char(start_time,'DD-Mon-YYYY hh24:mi:ss') stime, message,time_remaining "Remaining time in seconds" , round(( sofar/totalwork)* 100) percent
from v$session_longops
where sofar/totalwork < 1
--and username not in ('SYS','SYSTEM')
--and sid in (5215, 9536)
and totalwork != 0
order by start_time desc;