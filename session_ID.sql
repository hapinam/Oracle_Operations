select sid, SERIAL#, username, status, osuser, machine, program, sql_id, terminal, module, logon_time, client_info, client_identifier
from v$session 
--where sid in (12613) 
--or osuser='985'
--or status= 'ACTIVE'
order by logon_time;

--alter system kill session '12613,64775' immediate;