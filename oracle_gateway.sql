A 
create initfile in below path:
/app/oracle/product/11.2.0/gtw_sql/dg4msql/admin
vi initdg4msql4.ora
HS_FDS_CONNECT_INFO=[172.25.12.50]:1433//LGFOLLOWUP
ServerIP, Port, SID


B
Add new entry in the LISTENER and TNSNAMES file:
LISTENER

(SID_DESC=
         (SID_NAME=dg4msql4)
         (ORACLE_HOME=/app/oracle/product/11.2.0/gtw_sql)
         (PROGRAM=/app/oracle/product/11.2.0/gtw_sql/bin/dg4msql)
         (ENVS=LIBPATH=/app/oracle/product/11.2.0/gtw_sql/dg4msql/driver/lib:/app/oracle/product/11.2.0/gtw_sql/lib)
     )
	 

	 TNSNAMES
dg4msql4 =
  (DESCRIPTION=
    (ADDRESS=(PROTOCOL=tcp)(HOST=localhost)(PORT=1521))
    (CONNECT_DATA=(SID=dg4msql4))
    (HS=OK)
  )

  
C
Relaod the listener


D
Create the dblink
CREATE PUBLIC DATABASE LINK MSQL4
 CONNECT TO LGFOLLOWUP
 IDENTIFIED BY <PWD>
 USING 'dg4msql4';