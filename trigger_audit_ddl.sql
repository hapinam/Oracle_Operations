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
