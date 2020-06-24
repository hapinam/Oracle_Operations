select SADDR, SID, SERIAL#, MODULE, ACTION,substr(s.username,1,15) "username",
STATUS,substr(s.OSUSER,1,30) "osuser",
substr(s.PROGRAM,1,20) "OS PROGRAM",s.machine 
from v$session s
where SID in (select sid from v$lock where block=1); 