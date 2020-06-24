select owner,object_name 
from dba_objects 
where status='INVALID';

select owner,count(object_name) 
from dba_objects 
where status='INVALID' 
group by owner;


select status,object_name,object_type,owner
from dba_objects
where  status <> 'VALID' and object_name not like 'DBA_HIST%'
order by owner,object_type,object_name;


select status,object_name,object_type,owner
from dba_objects
WHERE object_type='VIEW' and status <> 'VALID' and object_name not like 'DBA_HIST%'
order by owner,object_type,object_name;