------------------------------------------------------------------------------
-- Script    : instance/pfile_spfile_conversion.sql
-- Purpose   : Create a pfile from the spfile and the other way round, the
--             normal way to back up or edit instance parameters.
-- Usage     : sqlplus / as sysdba @instance/pfile_spfile_conversion.sql
-- Requires  : SYSDBA
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : CREATE SPFILE overwrites the existing spfile and only takes
--             effect after the next restart.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

create spfile from pfile='/u01/app/oracle/product/12.1.0/dbhome_1/dbs/initorcl.ora';

create pfile='/u01/app/oracle/product/12.1.0/dbhome_1/dbs/spfileorcl.ora' from spfile;
