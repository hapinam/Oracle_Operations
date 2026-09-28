------------------------------------------------------------------------------
-- Script    : objects/drop_table_partition.sql
-- Purpose   : List the partitions of a table and drop an old partition,
--             optionally switching the table to an interval partitioning
--             scheme first.
-- Usage     : sqlplus / as sysdba @objects/drop_table_partition.sql
-- Requires  : ALTER ANY TABLE, or ownership of the table
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : DROP PARTITION permanently deletes the data in that partition.
--             Confirm the partition name and take a backup or export first.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

SELECT table_name,partition_name FROM all_tab_partitions WHERE table_owner='OWNER' AND table_name like '%TABLE_NAME';

###no need for the first statement#############
ALTER TABLE owner.table_name SET INTERVAL ( numtoyminterval (6,'MONTH') );
ALTER TABLE owner.table_name DROP PARTITION DMY_gtw_init;
