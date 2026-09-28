------------------------------------------------------------------------------
-- Script    : instance/set_management_pack_access.sql
-- Purpose   : Read and change CONTROL_MANAGEMENT_PACK_ACCESS, which enables
--             or disables AWR, ADDM and the tuning pack.
-- Usage     : sqlplus / as sysdba @instance/set_management_pack_access.sql
-- Requires  : SYSDBA
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : These packs are separately licensed by Oracle. Only enable
--             them if your licence covers them; enabling them changes what
--             AWR collects.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

-- What is enabled today?
SHOW PARAMETER control_management_pack_access

-- NONE                 : no AWR, no ADDM, no tuning pack
-- DIAGNOSTIC           : AWR, ASH and ADDM (Diagnostics Pack licence)
-- DIAGNOSTIC+TUNING    : the above plus SQL Tuning Advisor (Tuning Pack licence)
ALTER SYSTEM SET control_management_pack_access = 'DIAGNOSTIC+TUNING' SCOPE = BOTH;
