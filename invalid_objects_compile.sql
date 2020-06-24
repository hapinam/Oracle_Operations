select 'alter '||upper('&object_type')||' '||owner||'.'||object_name||' compile;' 
from dba_objects where object_type=upper('&object_type')
AND status <> 'VALID' order by owner;