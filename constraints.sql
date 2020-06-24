select a.owner, a.table_name "child tables",a.constraint_name "constraint to be disabled"
from dba_constraints a,dba_constraints b
where a.constraint_type='R' and  a.r_constraint_name= b.constraint_name and (b.constraint_type='P' or b.constraint_type='U' )
order by a.owner;
