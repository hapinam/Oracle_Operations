select  
'alter user "'||username||'" identified by values '''||extract(xmltype(dbms_metadata.get_xml('USER',username)),'//USER_T/PASSWORD/text()').getStringVal()||''' account unlock;'  old_password  
from  
   dba_users
where
username = 'OWNER';


12c

select replace(DBMS_METADATA.GET_DDL('USER','OWNER'),'CREATE USER','ALTER USER') from dual;