ALTER DATABASE DROP LOGFILE GROUP 1;
ALTER DATABASE DROP LOGFILE GROUP 2;
ALTER DATABASE DROP LOGFILE GROUP 3;
ALTER DATABASE ADD LOGFILE GROUP 1 ('/u01/app/oracle/oralogs/aibprod/redo01.log', '/u01/app/oracle/oralogs/aibprod/redo11.log') size 1g reuse;
ALTER DATABASE ADD LOGFILE GROUP 2 ('/u01/app/oracle/oralogs/aibprod/redo02.log', '/u01/app/oracle/oralogs/aibprod/redo22.log') size 1g reuse;
ALTER DATABASE ADD LOGFILE GROUP 3 ('/u01/app/oracle/oralogs/aibprod/redo03.log', '/u01/app/oracle/oralogs/aibprod/redo33.log') size 1g reuse;

ALTER DATABASE DROP STANDBY LOGFILE GROUP 4;
ALTER DATABASE DROP STANDBY LOGFILE GROUP 5;
ALTER DATABASE DROP STANDBY LOGFILE GROUP 6;
ALTER DATABASE ADD STANDBY LOGFILE GROUP 4 ('/u01/app/oracle/oralogs/aibprod/redo04.log', '/u01/app/oracle/oralogs/aibprod/redo44.log') size 1g reuse;
ALTER DATABASE ADD STANDBY LOGFILE GROUP 5 ('/u01/app/oracle/oralogs/aibprod/redo05.log', '/u01/app/oracle/oralogs/aibprod/redo55.log') size 1g reuse;
ALTER DATABASE ADD STANDBY LOGFILE GROUP 6 ('/u01/app/oracle/oralogs/aibprod/redo06.log', '/u01/app/oracle/oralogs/aibprod/redo66.log') size 1g reuse;