select * from(select owner,segment_name,bytes/(1024*1024) mb
              from dba_segments
              where tablespace_name = 'USERS'
              order by blocks desc);