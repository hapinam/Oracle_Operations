------------------------------------------------------------------------------
-- Script    : security/trigger_audit_ddl.sql
-- Purpose   : Database level trigger that records every DDL statement into
--             an audit table.
-- Usage     : sqlplus / as sysdba @security/trigger_audit_ddl.sql
-- Requires  : SYSDBA (ADMINISTER DATABASE TRIGGER)
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : A failing database wide trigger can block all DDL. Test on a
--             non production database and keep the audit table in its own
--             tablespace.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER SYS.audit_ddl_trg after ddl on database
begin
  if (ora_sysevent='TRUNCATE')
  then
    null; -- I do not care about truncate
  else
    insert into audit_ddl(d, osuser,current_user,host,terminal,owner,type,name,sysevent)
    values(
      sysdate,
      sys_context('USERENV','OS_USER') ,
      sys_context('USERENV','CURRENT_USER') ,
      sys_context('USERENV','HOST') ,
      sys_context('USERENV','TERMINAL') ,
      ora_dict_obj_owner,
      ora_dict_obj_type,
      ora_dict_obj_name,
      ora_sysevent
    );
  end if;
end;
/
