------------------------------------------------------------------------------
-- Script    : instance/fixed_date_parameter.sql
-- Purpose   : Read and set the FIXED_DATE parameter, which makes SYSDATE
--             return a fixed value for testing.
-- Usage     : sqlplus / as sysdba @instance/fixed_date_parameter.sql
-- Requires  : SYSDBA (ALTER SYSTEM)
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : FIXED_DATE affects every session in the instance. Never set it
--             on production; always reset it to NONE when finished.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select sysdate from dual;
alter system set fixed_date ='2014/06/18' scope=memory;
