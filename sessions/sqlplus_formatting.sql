------------------------------------------------------------------------------
-- Script    : sessions/sqlplus_formatting.sql
-- Purpose   : SQL*Plus formatting settings that make report output readable,
--             meant to be sourced before other scripts.
-- Usage     : sqlplus / as sysdba @sessions/sqlplus_formatting.sql
-- Requires  : CREATE SESSION
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

SET autotrace trace explaine;
SET timing on;
SET LINESIZE 400
SET PAGESIZE 500
SET SERVEROUTPUT ON
SET FEEDBACK OFF ;
set echo off;
set heading on;
SET VERIFY OFF ;
SET LONG 99999999
