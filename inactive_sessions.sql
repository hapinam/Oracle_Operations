select machine,osuser,username,count(*)
from v$session 
where status='INACTIVE'
group by machine,osuser,username
order by 4 desc;