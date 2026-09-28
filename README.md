# Oracle Operations

A working toolkit of SQL scripts and operational notes for the day to day
running of Oracle databases: sessions and locks, tablespaces and growth, users
and auditing, scheduler jobs, redo and archiving, patching and upgrades, RAC
and Data Guard.

These are the scripts I actually use as an Oracle DBA, cleaned up, documented
and grouped by the task they belong to. Every script carries a header that says
what it does, how to run it, which privileges it needs and what it can break.

## Contents

- [Requirements](#requirements)
- [How to use these scripts](#how-to-use-these-scripts)
- [Safety rules](#safety-rules)
- [Script index](#script-index)
- [Conventions](#conventions)
- [Contributing](#contributing)
- [Licence](#licence)

## Requirements

| Item | Detail |
| --- | --- |
| Database | Oracle Database 11gR2, 12cR1 and 12cR2. Most scripts also work on 18c and 19c; a few read dictionary views that changed between releases. |
| Client | SQL*Plus, or SQLcl / SQL Developer. The shell notes assume Linux or AIX. |
| Privileges | Reporting scripts need `SELECT_CATALOG_ROLE`. Maintenance scripts need `SYSDBA` or a specific system privilege; each header states which. |
| Platform notes | RAC, ASM and Grid Infrastructure notes assume 18c Grid; the gateway notes assume Oracle Database Gateway for SQL Server. |

## How to use these scripts

Clone the repository on the database server or on a workstation with a
configured Oracle client:

```bash
git clone https://github.com/hapinam/Oracle_Operations.git
cd Oracle_Operations
```

Run a script from SQL*Plus. Scripts that need a value prompt for it through a
substitution variable, so nothing is hard coded:

```bash
sqlplus / as sysdba @storage/tablespace_usage.sql
sqlplus / as sysdba @sessions/kill_session.sql
```

Load the SQL*Plus formatting settings first if you want readable report output:

```sql
@sessions/sqlplus_formatting.sql
@storage/tablespace_usage.sql
```

Files ending in `.md` are operational notes rather than runnable scripts: they
record the sequence of commands for a task such as applying a PSU or upgrading
with DBUA. Read them, adapt the paths, then run the commands yourself.

## Safety rules

Many scripts in this repository change or delete data.

1. **Read the header first.** Any script that can destroy data, block users or
   require an outage carries a `WARNING` line at the top.
2. **Never paste real credentials into these files.** Connect with OS
   authentication (`/ as sysdba`) or a wallet. Passwords, password verifiers,
   hostnames and IP addresses in this repository are placeholders such as
   `<password_verifier>`, `APP_USER` or `<sqlserver_host>`.
3. **Test on a non production database first**, especially the database level
   triggers, the partitioning templates and anything under `patching/`.
4. **Take a backup or a guaranteed restore point** before any script that drops,
   moves or rebuilds an object.

## Script index

### Data Guard and archiving (`dataguard/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`applied_archive_logs.sql`](dataguard/applied_archive_logs.sql) | Show which archived redo logs have been applied, used to check Data Guard apply progress and gaps. |  |
| [`archivelog_mode_status.sql`](dataguard/archivelog_mode_status.sql) | Report the archive log mode, destinations and current log sequence of the database. |  |
| [`physical_standby_notes.md`](dataguard/physical_standby_notes.md) | My Oracle Support document references used when building a physical standby with RMAN duplicate. |  |
| [`redo_generated_per_day.sql`](dataguard/redo_generated_per_day.sql) | Summarise redo volume per day and per hour, used for sizing archive storage and standby bandwidth. |  |

### Data Pump (`datapump/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`expdp_schema.par`](datapump/expdp_schema.par) | Data Pump parameter file for a full schema export. | read the warning in the header |

### Database gateway (`gateway/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`dg4msql_setup.md`](gateway/dg4msql_setup.md) | Configuration steps for reaching a Microsoft SQL Server database from Oracle through the heterogeneous services gateway. | read the warning in the header |

### Instance and parameters (`instance/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`add_redolog_member.sql`](instance/add_redolog_member.sql) | Add a member to an existing online redo log group and drop a member that is no longer needed. | read the warning in the header |
| [`fixed_date_parameter.sql`](instance/fixed_date_parameter.sql) | Read and set the FIXED_DATE parameter, which makes SYSDATE return a fixed value for testing. | read the warning in the header |
| [`pfile_spfile_conversion.sql`](instance/pfile_spfile_conversion.sql) | Create a pfile from the spfile and the other way round, the normal way to back up or edit instance parameters. | read the warning in the header |
| [`rebuild_catalog_and_recompile.sql`](instance/rebuild_catalog_and_recompile.sql) | Rerun the catalog scripts and recompile invalid objects after a patch or upgrade. | read the warning in the header |
| [`recreate_redolog_groups.sql`](instance/recreate_redolog_groups.sql) | Add online and standby redo log groups, switch away from the old ones and drop them, the normal way to resize redo. | read the warning in the header |
| [`set_management_pack_access.sql`](instance/set_management_pack_access.sql) | Read and change CONTROL_MANAGEMENT_PACK_ACCESS, which enables or disables AWR, ADDM and the tuning pack. | read the warning in the header |
| [`sga_pga_sizing.sql`](instance/sga_pga_sizing.sql) | Report the current SGA and PGA allocation and the advisors that suggest better sizes. |  |
| [`show_parameters.sql`](instance/show_parameters.sql) | Read instance parameters, including the hidden underscore parameters and their default status. | read the warning in the header |
| [`sqlnet.ora.sample`](instance/sqlnet.ora.sample) | Sample sqlnet.ora showing name resolution order and the logon version settings needed when old clients must still connect. | read the warning in the header |
| [`timezone_version.sql`](instance/timezone_version.sql) | Check the database time zone and the DST time zone file version, needed before an upgrade. |  |

### Scheduler jobs (`jobs/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`autotask_windows.sql`](jobs/autotask_windows.sql) | Inspect the automated maintenance windows and the tasks attached to them (optimizer stats, segment advisor, SQL tuning advisor). |  |
| [`create_scheduler_job.sql`](jobs/create_scheduler_job.sql) | Create a DBMS_SCHEDULER job that runs a PL/SQL block on a daily schedule, with logging and restart attributes. |  |
| [`enable_disable_autotask.sql`](jobs/enable_disable_autotask.sql) | Enable or disable the automated maintenance tasks such as the automatic optimizer statistics job. | read the warning in the header |
| [`gather_stats_job.sql`](jobs/gather_stats_job.sql) | Create, run and drop a DBMS_SCHEDULER job that gathers database wide optimizer statistics. | read the warning in the header |
| [`job_programs_and_schedules.sql`](jobs/job_programs_and_schedules.sql) | List scheduler jobs with their programs, schedules, state and next run date. |  |
| [`job_run_history.sql`](jobs/job_run_history.sql) | Read the scheduler run history and failure details for a job. |  |
| [`purge_job_log.sql`](jobs/purge_job_log.sql) | Purge the scheduler log to stop SYSAUX growing because of job history. | read the warning in the header |

### Middleware (`middleware/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`weblogic_version.md`](middleware/weblogic_version.md) | How to read the exact WebLogic Server version from the installed jar. |  |

### Schema objects (`objects/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`compare_table_columns.sql`](objects/compare_table_columns.sql) | Compare the column list of two tables, used before a rebuild or a migration to confirm the structures match. |  |
| [`constraints_report.sql`](objects/constraints_report.sql) | List constraints and their columns for a table, including foreign keys pointing at it. |  |
| [`create_database_link.sql`](objects/create_database_link.sql) | Create a public database link, list existing links and drop one. | read the warning in the header |
| [`create_partitioned_history_table.sql`](objects/create_partitioned_history_table.sql) | Worked example of recreating a large history table as a partitioned table with its indexes, kept as a template. | read the warning in the header |
| [`create_range_partitioned_table.sql`](objects/create_range_partitioned_table.sql) | Worked example of a range partitioned table with local and global indexes, kept as a template for new partitioned objects. | read the warning in the header |
| [`drop_table_partition.sql`](objects/drop_table_partition.sql) | List the partitions of a table and drop an old partition, optionally switching the table to an interval partitioning scheme first. | read the warning in the header |
| [`find_object_owner.sql`](objects/find_object_owner.sql) | Find which schema owns an object when only the object name is known. |  |
| [`generate_disable_constraints.sql`](objects/generate_disable_constraints.sql) | Generate the ALTER TABLE statements needed to disable all non key constraints in the current schema. | read the warning in the header |
| [`index_rebuild_parallel.sql`](objects/index_rebuild_parallel.sql) | Generate parallel, online rebuild statements for the large indexes of a schema, to speed up bulk index maintenance. | read the warning in the header |
| [`index_reset_parallelism.sql`](objects/index_reset_parallelism.sql) | Reset the degree of parallelism on indexes back to NOPARALLEL after a parallel rebuild, for one index or for every large index of a schema. | read the warning in the header |
| [`indexes_of_table.sql`](objects/indexes_of_table.sql) | List the indexes of a table together with their indexed columns and column order. |  |
| [`invalid_objects_count.sql`](objects/invalid_objects_count.sql) | Count invalid objects per owner and object type, the quickest health check after maintenance. |  |
| [`materialized_views.sql`](objects/materialized_views.sql) | Inspect materialized views and their refresh status, and refresh one manually. | read the warning in the header |
| [`public_synonyms.sql`](objects/public_synonyms.sql) | List public synonyms and generate the statements to recreate or drop them. | read the warning in the header |
| [`recompile_invalid_objects.sql`](objects/recompile_invalid_objects.sql) | Generate and run the statements that recompile invalid objects after a patch, upgrade or DDL change. | read the warning in the header |
| [`recompile_schema.sql`](objects/recompile_schema.sql) | Recompile all objects of a schema with UTL_RECOMP, used after a schema wide change. | read the warning in the header |
| [`rename_table.sql`](objects/rename_table.sql) | Rename a table and copy its rows into a freshly created table of the same name, the usual pattern before a restructure. | read the warning in the header |
| [`tables_and_indexes.sql`](objects/tables_and_indexes.sql) | List tables with their indexes and sizes for a schema. |  |
| [`unusable_indexes.sql`](objects/unusable_indexes.sql) | List index partitions left in an UNUSABLE state, usually after a partition maintenance operation. | read the warning in the header |

### Patching and upgrades (`patching/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`opatch_inventory.md`](patching/opatch_inventory.md) | Commands that list the patches installed in an Oracle home. |  |
| [`patching_and_psu.md`](patching/patching_and_psu.md) | Working notes for applying Oracle database patches with OPatch, plus the queries that confirm which patches are installed. | read the warning in the header |
| [`runinstaller_ignore_prereqs.md`](patching/runinstaller_ignore_prereqs.md) | How to start the Oracle installer when a prerequisite check fails on an unsupported but known good platform. | read the warning in the header |
| [`upgrade_10g_to_11g_linux.md`](patching/upgrade_10g_to_11g_linux.md) | Manual upgrade notes for moving a 10g database to 11g on Linux, including the pre upgrade checks and the post upgrade tasks. | read the warning in the header |
| [`upgrade_with_dbua.md`](patching/upgrade_with_dbua.md) | Step by step notes for an 11g to 12c upgrade with the Database Upgrade Assistant, in the order the steps were actually performed. | read the warning in the header |

### Performance (`performance/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`rename_sql_profile.sql`](performance/rename_sql_profile.sql) | Rename a SQL profile with DBMS_SQLTUNE so it can be transported or kept under a meaningful name. |  |

### RAC and Grid Infrastructure (`rac/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`grid_and_asm_commands.md`](rac/grid_and_asm_commands.md) | Commands for setting the grid environment and inspecting ASM disk groups with `asmcmd`. |  |
| [`srvctl_commands.md`](rac/srvctl_commands.md) | Common `srvctl` commands for starting, stopping and inspecting clustered databases, listeners and VIPs. | read the warning in the header |

### Backup and recovery (`recovery/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`drop_datapump_master_tables.sql`](recovery/drop_datapump_master_tables.sql) | Find and drop orphaned Data Pump master tables left behind by failed or killed export and import jobs. | read the warning in the header |
| [`flashback_database.sql`](recovery/flashback_database.sql) | Create a guaranteed restore point, check flashback retention, and flash the database back to that point. | read the warning in the header |

### Users, privileges and auditing (`security/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`audit_settings.sql`](security/audit_settings.sql) | Show which statements, privileges and objects are currently being audited. |  |
| [`create_password_file.md`](security/create_password_file.md) | How to create the password file that allows remote SYSDBA connections. | read the warning in the header |
| [`extract_user_ddl.sql`](security/extract_user_ddl.sql) | Extract the CREATE USER and GRANT statements for an existing user with DBMS_METADATA so the account can be recreated on another database. | read the warning in the header |
| [`last_login_time.sql`](security/last_login_time.sql) | Report the last successful logon time of each database account, used to find dormant users. |  |
| [`list_users.sql`](security/list_users.sql) | List database users with their default and temporary tablespaces. |  |
| [`password_verify_function.sql`](security/password_verify_function.sql) | Install the Oracle supplied password complexity functions and attach one to a profile. | read the warning in the header |
| [`privileges_excluding_public.sql`](security/privileges_excluding_public.sql) | Report object and system privileges granted to real users, filtering out the noise granted to PUBLIC. |  |
| [`rename_database_user.sql`](security/rename_database_user.sql) | Rename a database account by updating the data dictionary directly. | read the warning in the header |
| [`reset_user_to_previous_password.sql`](security/reset_user_to_previous_password.sql) | Read the stored password verifier of a user and restore it with IDENTIFIED BY VALUES after a temporary password change. | read the warning in the header |
| [`trigger_audit_ddl.sql`](security/trigger_audit_ddl.sql) | Database level trigger that records every DDL statement into an audit table. | read the warning in the header |
| [`trigger_logon_logoff_audit.sql`](security/trigger_logon_logoff_audit.sql) | Audit table, logon and logoff triggers and a public synonym that record who connected to the database and when. | read the warning in the header |
| [`user_password_expiry.sql`](security/user_password_expiry.sql) | Check when an account's password expires, and restore a previous password from its stored verifier after a temporary change. | read the warning in the header |
| [`users_with_dba_privileges.sql`](security/users_with_dba_privileges.sql) | List the accounts and roles that hold DBA or other powerful system privileges. |  |

### Sessions and SQL*Plus (`sessions/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`blocking_sessions.sql`](sessions/blocking_sessions.sql) | Show the sessions that are currently blocking other sessions, with the OS user, program and machine behind them. |  |
| [`inactive_sessions.sql`](sessions/inactive_sessions.sql) | List inactive sessions with their idle time, to find connections that should be closed by the application. |  |
| [`kill_session.sql`](sessions/kill_session.sql) | Find a session by user, program or SQL and terminate it, including the OS level kill for a hung process. | read the warning in the header |
| [`locks.sql`](sessions/locks.sql) | Show current locks, the objects locked and the sessions holding or waiting for them. |  |
| [`long_operations.sql`](sessions/long_operations.sql) | Show long running operations from V$SESSION_LONGOPS with the percentage complete. |  |
| [`long_operations_time_remaining.sql`](sessions/long_operations_time_remaining.sql) | Estimate the time remaining for long running operations from V$SESSION_LONGOPS. |  |
| [`memory_per_session.sql`](sessions/memory_per_session.sql) | Report PGA and UGA memory used per session, to find the sessions driving memory pressure. |  |
| [`open_cursors.sql`](sessions/open_cursors.sql) | Show open cursors per session against the OPEN_CURSORS limit, to diagnose ORA-01000. |  |
| [`session_counts.sql`](sessions/session_counts.sql) | Count sessions by status, user and machine against the SESSIONS and PROCESSES limits. |  |
| [`session_details.sql`](sessions/session_details.sql) | Find the SID, serial number and OS process of a session from the user, program or client machine. |  |
| [`session_logon_time.sql`](sessions/session_logon_time.sql) | List sessions with their logon time and idle time, with a reminder of the important V$SESSION columns. |  |
| [`session_sql_text.sql`](sessions/session_sql_text.sql) | Show the SQL text each active session is currently running. |  |
| [`set_current_schema.sql`](sessions/set_current_schema.sql) | Switch the current schema of the session so unqualified object names resolve to another owner. |  |
| [`set_date_format.sql`](sessions/set_date_format.sql) | Set the NLS date format for the current session so DATE columns print with time. |  |
| [`sqlplus_formatting.sql`](sessions/sqlplus_formatting.sql) | SQL*Plus formatting settings that make report output readable, meant to be sourced before other scripts. |  |

### Tablespaces and storage (`storage/`)

| Script | What it does | Caution |
| --- | --- | --- |
| [`add_datafile_asm_rac.sql`](storage/add_datafile_asm_rac.sql) | Add a datafile to a tablespace on ASM storage in a RAC database. | read the warning in the header |
| [`add_datafile_filesystem.sql`](storage/add_datafile_filesystem.sql) | Add a datafile to a tablespace on a file system, and resize or autoextend an existing one. | read the warning in the header |
| [`corrupted_segments.sql`](storage/corrupted_segments.sql) | Map corrupted blocks reported in V$DATABASE_BLOCK_CORRUPTION back to the segments that own them. | read the warning in the header |
| [`move_table_and_index.sql`](storage/move_table_and_index.sql) | Move a table to another tablespace and rebuild its indexes there. | read the warning in the header |
| [`segment_growth_tracking.sql`](storage/segment_growth_tracking.sql) | Create the tables and the job that snapshot segment sizes and row counts so database growth can be trended over time. | read the warning in the header |
| [`sysaux_purge.sql`](storage/sysaux_purge.sql) | Find what is filling SYSAUX and purge old AWR snapshots to reclaim the space. | read the warning in the header |
| [`tablespace_fragmentation.sql`](storage/tablespace_fragmentation.sql) | Measure free space fragmentation inside tablespaces and find segments whose extents are badly fragmented. |  |
| [`tablespace_usage.sql`](storage/tablespace_usage.sql) | Report tablespace free space, used space and percentage full, plus the datafiles behind each tablespace. |  |
| [`temp_tablespace_usage.sql`](storage/temp_tablespace_usage.sql) | Report temporary tablespace usage and which sessions are consuming temp space. |  |
| [`undo_tablespace_usage.sql`](storage/undo_tablespace_usage.sql) | Report undo tablespace usage by extent status and show which transactions are consuming undo. |  |

## Conventions

Every SQL script starts with the same header so it can be reviewed before it is
run:

```sql
------------------------------------------------------------------------------
-- Script    : storage/tablespace_usage.sql
-- Purpose   : What the script does, in one or two lines.
-- Usage     : sqlplus / as sysdba @storage/tablespace_usage.sql
-- Requires  : The privileges or roles the script needs.
-- Tested on : Oracle Database 11gR2, 12cR1 and 12cR2
-- WARNING   : Present only when the script can destroy data, block users
--             or require an outage.
--
-- Copyright (c) 2026 Mohamed Dawood. Licensed under the MIT License; see LICENSE.
------------------------------------------------------------------------------
```

Other conventions:

- Values that change per environment are SQL*Plus substitution variables
  (`&&account_name`), never hard coded names.
- Statements that destroy something are left commented out, so a script cannot
  delete anything just by being run by accident.
- Shell and OPatch sequences live in `.md` notes, not in files named `.sql`.
- Files are grouped in a directory named after the task, and named after what
  they do rather than after the view they query.

## Contributing

Corrections and additional scripts are welcome. Please keep the header format
above, put the file in the directory that matches the task, and make sure no
real hostname, schema name, password or password verifier is included.

## Licence

Released under the [MIT Licence](LICENSE).

Copyright (c) 2026 Mohamed Dawood.
