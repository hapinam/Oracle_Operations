ALTER MATERIALIZED VIEW COL.ORACLE_VACATIONS
REFRESH COMPLETE
START WITH SYSDATE
NEXT TRUNC(SYSDATE) + 1;