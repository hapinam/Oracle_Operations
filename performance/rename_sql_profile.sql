------------------------------------------------------------------------------
-- Script    : performance/rename_sql_profile.sql
-- Purpose   : Rename a SQL profile with DBMS_SQLTUNE so it can be
--             transported or kept under a meaningful name.
-- Usage     : sqlplus / as sysdba @performance/rename_sql_profile.sql
-- Requires  : ADMINISTER SQL MANAGEMENT OBJECT
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

exec dbms_sqltune.alter_sql_profile ( NAME => 'SYS_SQLPROF_016772eb1d720000', attribute_name =>'NAME', VALUE =>'SQLPROF_2bk095wbjagwh');
exec dbms_sqltune.alter_sql_profile ( NAME => 'SYS_SQLPROF_0167738f9fca0002', attribute_name =>'NAME', VALUE =>'SQLPROF_209tt7jhn3fvh');
exec dbms_sqltune.alter_sql_profile ( NAME => 'SYS_SQLPROF_0167738f84110001', attribute_name =>'NAME', VALUE =>'SQLPROF_0z6pk5pf6ah0u');
exec dbms_sqltune.alter_sql_profile ( NAME => 'SYS_SQLPROF_0167738fb26d0003', attribute_name =>'NAME', VALUE =>'SQLPROF_2q1qxpsysb42b');
exec dbms_sqltune.alter_sql_profile ( NAME => 'SYS_SQLPROF_0167740b78340006', attribute_name =>'NAME', VALUE =>'SQLPROF_02sdsbt4arptp');
exec dbms_sqltune.alter_sql_profile ( NAME => 'SYS_SQLPROF_016773e7e2cf0005', attribute_name =>'NAME', VALUE =>'SQLPROF_3r425r0wrba2r');
exec dbms_sqltune.alter_sql_profile ( NAME => 'SYS_SQLPROF_016773934f540004', attribute_name =>'NAME', VALUE =>'SQLPROF_fqf9jtdcqq78a');
exec dbms_sqltune.alter_sql_profile ( NAME => 'SYS_SQLPROF_016774286dc30008', attribute_name =>'NAME', VALUE =>'SQLPROF_ba7w88sck5ca9');
