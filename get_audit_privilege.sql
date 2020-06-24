###list of users

select USERNAME,ACCOUNT_STATUS,LOCK_DATE,CREATED,PROFILE 
from sys.dba_users;



###list of roles privilege

select * from sys.role_tab_privs;

###list of roles granted to users

select * from sys.dba_role_privs
where grantee not in (select role from sys.dba_roles);


###system privilege

select * from sys.dba_sys_privs;




