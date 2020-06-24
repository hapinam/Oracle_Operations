-- IMPORTANT V$SESSION ATTRIBUTES
-- SID        raw(4)         Session identifier
-- SERIAL#    NUMBER         Session serial number. Used to
--                           identify uniquely a session's objects.
--                           Guarantees that session-level
--                           commands are applied to the correct
--                           session objects if the session ends
--                           and another session begins with
--                           the same session ID.
-- USERNAME  VARCHAR2(30)    ORACLE USER
-- STATUS    VARCHAR2(8)     ACTIVE,INACTIVE,MARKED TO BE KILLED
-- OSUSER    VARCHAR2(15)    OPERATING SYSTEM USER CONNECTED TO ORACLE
-- PROGRAN   VARCHAR2(64)    OPERATING SYSTEM PROGRAM NAME CURENTLY RUNNING

set linesize 200

col "machine" format a20

SELECT s.sid, s.serial#, substr(s.username,1,15) "username",
STATUS,substr(s.OSUSER,1,30) "osuser",
substr(s.PROGRAM,1,20) "OS PROGRAM",s.machine ,
to_char(s.logon_time,'DD-MM-RRRR HH24:MI:SS') "logon time",
w.seconds_in_wait/60 "idle time/min"
FROM v$session s, v$session_wait w
where  s.sid=w.sid(+)
and   'SQL*Net message from client' = w.event(+)
and   s.username is not null
ORDER BY s.logon_time,s.username;
