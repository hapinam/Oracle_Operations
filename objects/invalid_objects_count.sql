------------------------------------------------------------------------------
-- Script    : objects/invalid_objects_count.sql
-- Purpose   : Count invalid objects per owner and object type, the quickest
--             health check after maintenance.
-- Usage     : sqlplus / as sysdba @objects/invalid_objects_count.sql
-- Requires  : SELECT_CATALOG_ROLE
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

select owner,object_name
from dba_objects
where status='INVALID';

select owner,count(object_name)
from dba_objects
where status='INVALID'
group by owner;


select status,object_name,object_type,owner
from dba_objects
where  status <> 'VALID' and object_name not like 'DBA_HIST%'
order by owner,object_type,object_name;


select status,object_name,object_type,owner
from dba_objects
WHERE object_type='VIEW' and status <> 'VALID' and object_name not like 'DBA_HIST%'
order by owner,object_type,object_name;
