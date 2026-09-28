------------------------------------------------------------------------------
-- Script    : instance/sga_pga_sizing.sql
-- Purpose   : Report the current SGA and PGA allocation and the advisors
--             that suggest better sizes.
-- Usage     : sqlplus / as sysdba @instance/sga_pga_sizing.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

SELECT * FROM V$SGA_DYNAMIC_COMPONENTS ;
SELECT * FROM V$SGAINFO ;
