------------------------------------------------------------------------------
-- Script    : objects/materialized_views.sql
-- Purpose   : Inspect materialized views and their refresh status, and
--             refresh one manually.
-- Usage     : sqlplus / as sysdba @objects/materialized_views.sql
-- Requires  : SELECT_CATALOG_ROLE, plus ownership or ALTER ANY MATERIALIZED
--             VIEW to refresh
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : A complete refresh can take as long as the original query and
--             generates redo.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

ALTER MATERIALIZED VIEW COL.ORACLE_VACATIONS
REFRESH COMPLETE
START WITH SYSDATE
NEXT TRUNC(SYSDATE) + 1;
