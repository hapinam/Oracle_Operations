SELECT SEGMENT_TYPE,OWNER||'.'||SEGMENT_NAME
FROM DBA_EXTENTS 
WHERE FILE_ID = 12 AND 17116 BETWEEN BLOCK_ID
AND BLOCK_ID+BLOCKS -1;

