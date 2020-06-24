SELECT table_name,partition_name FROM all_tab_partitions WHERE table_owner='OWNER' AND table_name like '%TABLE_NAME';

###no need for the first statement#############
ALTER TABLE owner.table_name SET INTERVAL ( numtoyminterval (6,'MONTH') );
ALTER TABLE owner.table_name DROP PARTITION DMY_gtw_init;