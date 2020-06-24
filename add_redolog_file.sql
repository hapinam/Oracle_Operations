sql>select group#,archived,status from v$log

sql>ALTER DATABASE ADD LOGFILE MEMBER 'D:\oracle\product\10.2.0\oradata\orcl\redo04b.log' TO GROUP 3; 
sql>ALTER DATABASE ADD LOGFILE GROUP 4 ('/redo1/oradata/redo04a.log','/redo1/oradata/redo04b.log') SIZE 200M
sql>ALTER DATABASE DROP LOGFILE GROUP 1



----------------
select * from v$log
ALTER DATABASE ADD LOGFILE THREAD 1 GROUP 2 ('+REDO1/redo02a.log','+REDO2/redo02b.log') SIZE 10G
ALTER DATABASE DROP LOGFILE GROUP 2
ALTER system switch logfile;
ALTER system checkpoint;