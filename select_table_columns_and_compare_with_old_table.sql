select * from dba_tab_columns t
where table_name='VSA_ISO_MSG_GUI_TMP'
and column_name not in( select column_name from dba_tab_columns where table_name='VSA_ISO_MSG_GUI' );

select * from dba_tab_columns t
where table_name='VSA_ISO_MSG_GUI'
and column_name not in( select column_name from dba_tab_columns where table_name='VSA_ISO_MSG_GUI_TMP' );