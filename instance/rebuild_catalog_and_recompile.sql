------------------------------------------------------------------------------
-- Script    : instance/rebuild_catalog_and_recompile.sql
-- Purpose   : Rerun the catalog scripts and recompile invalid objects after
--             a patch or upgrade.
-- Usage     : sqlplus / as sysdba @instance/rebuild_catalog_and_recompile.sql
-- Requires  : SYSDBA
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : catalog.sql and catproc.sql rebuild the data dictionary and
--             can run for a long time. Run them only in a maintenance
--             window, ideally in restricted mode.
--
-- Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.
------------------------------------------------------------------------------

###to validate invalid database catalog component:
--------------------------------------------------

@?/rdbms/admin/utlrp.sql
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
