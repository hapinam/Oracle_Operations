select substr(username,1,20) "user name",default_tablespace,temporary_tablespace
from dba_users
order by username;
