select EXPIRY_DATE,profile from dba_users where username='WATCH4NET';

select password from sys.user$ where name='WATCH4NET';

--alter user WATCH4NET profile default;

alter user WATCH4NET identified by values '<password_verifier>';