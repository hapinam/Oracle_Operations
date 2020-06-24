with group1 as (select /*+ materialize parallel(t,2) ordered */
   to_char(s.begin_interval_time,'yyyy-mm-dd') get_date,
   --v.name ts_name,
(round(max((t.tablespace_size*8192))/1024/1024/1024,2)) size_gb,
(round(max((tablespace_usedsize*8192))/1024/1024/1024,2)) used_gb
from 
   dba_hist_tbspc_space_usage t, 
   v$tablespace               v, 
   dba_hist_snapshot          s
where 
   t.tablespace_id=v.ts#
and 
   t.snap_id=s.snap_id
group by to_char(s.begin_interval_time,'yyyy-mm-dd'), v.name)
select 
   get_date, 
   sum(size_gb) tot_size,
   sum(used_gb) used_size
from 
   group1
group by get_date
order by get_date;

select sum(bytes)/1024/1024 size_MB
from dba_Extents 
where TABLESPACE_NAME  not like '%TEMP%'; 

select sum(bytes)/1024/1024/1024 size_GB from V$datafile ;

col day for a8;
select
  to_char(first_time,'YY-MM-DD') day,
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'00',1,0)),'999') "00",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'01',1,0)),'999') "01",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'02',1,0)),'999') "02",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'03',1,0)),'999') "03",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'04',1,0)),'999') "04",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'05',1,0)),'999') "05",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'06',1,0)),'999') "06",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'07',1,0)),'999') "07",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'08',1,0)),'999') "08",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'09',1,0)),'999') "09",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'10',1,0)),'999') "10",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'11',1,0)),'999') "11",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'12',1,0)),'999') "12",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'13',1,0)),'999') "13",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'14',1,0)),'999') "14",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'15',1,0)),'999') "15",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'16',1,0)),'999') "16",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'17',1,0)),'999') "17",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'18',1,0)),'999') "18",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'19',1,0)),'999') "19",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'20',1,0)),'999') "20",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'21',1,0)),'999') "21",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'22',1,0)),'999') "22",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'23',1,0)),'999') "23",
  COUNT(*)
from v$log_history
group by to_char(first_time,'YY-MM-DD')
order by day ;
