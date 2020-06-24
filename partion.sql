DROP TABLE ATOMIC.FSI_D_ACTIVITY_BASED_COST_HIST CASCADE CONSTRAINTS;

CREATE TABLE ATOMIC.FSI_D_ACTIVITY_BASED_COST_HIST
(
  ID_NUMBER         NUMBER(25)                  NOT NULL,
  CUSTOMER_ID       NUMBER(25)                  NOT NULL,
  TRANS_BR          NUMBER(14)                  NOT NULL,
  ORIG_BR           NUMBER(14)                  NOT NULL,
  AS_OF_DATE        DATE                        NOT NULL,
  ISO_CURRENCY_CD   VARCHAR2(15 BYTE)           NOT NULL,
  RECORD_COUNT      NUMBER(6)                   NOT NULL,
  TRANSS_AMOUNT     NUMBER(22,2),
  LOB_ID            NUMBER(14)                  NOT NULL,
  CUSTOMER_SEG_ID   NUMBER(14)                  NOT NULL,
  ACTIVITY_CD       NUMBER(14)                  NOT NULL,
  CPM               NUMBER(14,2)                NOT NULL,
  TRANS_DURATION    NUMBER(14,2)                NOT NULL,
  TRANS_COST        NUMBER(14,2)                NOT NULL,
  NO_OF_TRANS       NUMBER(14)                  NOT NULL,
  TOTAL_TRANS_COST  NUMBER(22,2)                NOT NULL,
  LEGAL_ENTITY_ID   NUMBER(14)                  NOT NULL,
  YEAR              NUMBER(4),
  MONTH             NUMBER(4)
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
           PARTITION BY RANGE (YEAR, MONTH)
(  
  PARTITION YM_1909 VALUES LESS THAN (2019, 10)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION YM_1910 VALUES LESS THAN (2019, 11)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION YM_1911 VALUES LESS THAN (2019, 12)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION YM_1912 VALUES LESS THAN (2020, 01)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION YM_2001 VALUES LESS THAN (2020, 02)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION YM_2002 VALUES LESS THAN (2020, 03)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION YM_2003 VALUES LESS THAN (2020, 04)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION YM_2004 VALUES LESS THAN (2020, 05)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION YM_2005 VALUES LESS THAN (2020, 06)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION YM_2006 VALUES LESS THAN (2020, 07)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION YM_2007 VALUES LESS THAN (2020, 08)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION YM_2008 VALUES LESS THAN (2020, 09)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION YM_2009 VALUES LESS THAN (2020, 10)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION YM_2010 VALUES LESS THAN (2020, 11)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION YM_2011 VALUES LESS THAN (2020, 12)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION YM_2012 VALUES LESS THAN (2021, 01)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION YM_2101 VALUES LESS THAN (2021, 02)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION YM_2102 VALUES LESS THAN (2021, 03)
    LOGGING
    NOCOMPRESS 
    TABLESPACE DATA_TS
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;