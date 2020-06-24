CREATE TABLE ATOMIC.LEDGER_STAT
(
  IDENTITY_CODE      NUMBER(10)                 NOT NULL,
  YEAR_S             NUMBER(5)                  NOT NULL,
  GL_ACCOUNT_ID      NUMBER(14)                 NOT NULL,
  ACCUM_TYPE_CD      CHAR(1 CHAR)               NOT NULL,
  COMMON_COA_ID      NUMBER(14)                 NOT NULL,
  CONSOLIDATION_CD   NUMBER(5)                  NOT NULL,
  PRODUCT_ID         NUMBER(14)                 NOT NULL,
  ISO_CURRENCY_CD    VARCHAR2(15 CHAR)          NOT NULL,
  ORG_UNIT_ID        NUMBER(14)                 NOT NULL,
  MONTH_01           NUMBER(15,4),
  MONTH_02           NUMBER(15,4),
  MONTH_03           NUMBER(15,4),
  MONTH_04           NUMBER(15,4),
  MONTH_05           NUMBER(15,4),
  MONTH_06           NUMBER(15,4),
  MONTH_07           NUMBER(15,4),
  MONTH_08           NUMBER(15,4),
  MONTH_09           NUMBER(15,4),
  MONTH_10           NUMBER(15,4),
  MONTH_11           NUMBER(15,4),
  MONTH_12           NUMBER(15,4),
  YTD_01             NUMBER(15,4),
  YTD_02             NUMBER(15,4),
  YTD_03             NUMBER(15,4),
  YTD_04             NUMBER(15,4),
  YTD_05             NUMBER(15,4),
  YTD_06             NUMBER(15,4),
  YTD_07             NUMBER(15,4),
  YTD_08             NUMBER(15,4),
  YTD_09             NUMBER(15,4),
  YTD_10             NUMBER(15,4),
  YTD_11             NUMBER(15,4),
  YTD_12             NUMBER(15,4),
  BALANCE_TYPE_CD    NUMBER(5)                  NOT NULL,
  FINANCIAL_ELEM_ID  NUMBER(14)                 DEFAULT NULL                  NOT NULL,
  STRATEGY_ID        NUMBER(14)                 DEFAULT -1                    NOT NULL,
  LOB_ID             NUMBER(14)                 DEFAULT NULL,
  CUSTOMER_SEG_ID    NUMBER(14)                 DEFAULT NULL,
  COST_CENTER_ID     NUMBER(14)                 DEFAULT NULL,
  RPT_LINE_ID        NUMBER(14)                 DEFAULT NULL,
  CURRENCY_TYPE_CD   NUMBER(5)
)
TABLESPACE DATA_TS
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )

PARTITION BY RANGE (YEAR_S)
--INTERVAL( NUMTOYMINTERVAL (1,'YEAR'))
(  
  PARTITION YEAR_S_2017 VALUES LESS THAN (2018)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),

 
  PARTITION YEAR_S_2018 VALUES LESS THAN (2019)
  
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),

 
  PARTITION YEAR_S_2019 VALUES LESS THAN (2020)
  
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),

 
  PARTITION YEAR_S_2020 VALUES LESS THAN (2021)
  
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               )
)

NOLOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
MONITORING;


CREATE UNIQUE INDEX ATOMIC.LEDGER_STAT ON ATOMIC.LEDGER_STAT
(IDENTITY_CODE, YEAR_S, GL_ACCOUNT_ID, ACCUM_TYPE_CD, COMMON_COA_ID, 
CONSOLIDATION_CD, PRODUCT_ID, ISO_CURRENCY_CD, ORG_UNIT_ID, BALANCE_TYPE_CD, 
FINANCIAL_ELEM_ID, STRATEGY_ID, LOB_ID, CUSTOMER_SEG_ID, COST_CENTER_ID, 
RPT_LINE_ID)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX ATOMIC.LEDGER_STAT_102 ON ATOMIC.LEDGER_STAT
(PRODUCT_ID)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX ATOMIC.LEDGER_STAT_3 ON ATOMIC.LEDGER_STAT
(COMMON_COA_ID)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX ATOMIC.LEDGER_STAT_4 ON ATOMIC.LEDGER_STAT
(ORG_UNIT_ID)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX ATOMIC.LEDGER_STAT_5 ON ATOMIC.LEDGER_STAT
(GL_ACCOUNT_ID)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX ATOMIC.LEDGER_STAT_7 ON ATOMIC.LEDGER_STAT
(YEAR_S)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX ATOMIC.LEDGER_STAT_8 ON ATOMIC.LEDGER_STAT
(IDENTITY_CODE)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX ATOMIC.LEDGER_STAT_10 ON ATOMIC.LEDGER_STAT
(RPT_LINE_ID)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX ATOMIC.LEDGER_STAT_12 ON ATOMIC.LEDGER_STAT
(CUSTOMER_SEG_ID)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX ATOMIC.LEDGER_STAT_13 ON ATOMIC.LEDGER_STAT
(LOB_ID)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX ATOMIC.LEDGER_STAT_6 ON ATOMIC.LEDGER_STAT
(FINANCIAL_ELEM_ID)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX ATOMIC.LEDGER_STAT_9 ON ATOMIC.LEDGER_STAT
(COST_CENTER_ID)
LOGGING
TABLESPACE OFSA_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;