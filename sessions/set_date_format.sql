------------------------------------------------------------------------------
-- Script    : sessions/set_date_format.sql
-- Purpose   : Set the NLS date format for the current session so DATE
--             columns print with time.
-- Usage     : sqlplus / as sysdba @sessions/set_date_format.sql
-- Requires  : CREATE SESSION
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

alter session set nls_date_format = 'dd.mm.yyyy hh24:mi:ss';
select sysdate from dual;
