###recompile database objects:
------------------------------

@?/rdbms/admin/utlrp.sql

EXEC UTL_RECOMP.recomp_serial('SYS');