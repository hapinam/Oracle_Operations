alter table ATOMIC.LEDGER_STAT rename to LEDGER_STAT_OLD;

insert into ATOMIC.LEDGER_STAT select * from ATOMIC.LEDGER_STAT_OLD;