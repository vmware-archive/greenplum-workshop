SELECT
       schemaname as "Schema"
      ,tablename as "TblName"
      ,partitiontablename as "PartTblName"
      ,partitiontype as "Type"
      ,split_part(partitionrangestart, '::', 1) as "Start"
      ,split_part(partitionrangeend, '::', 1) as "End"
FROM
     pg_partitions
WHERE
      tablename = 'otp_rpm'
  AND schemaname = 'faa'
;
