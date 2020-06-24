select tablespace_name,count(*) "amount of freg.",max(blocks),sum(blocks) "free blocks"
from sys.dba_free_space
group by tablespace_name
order by tablespace_name;
