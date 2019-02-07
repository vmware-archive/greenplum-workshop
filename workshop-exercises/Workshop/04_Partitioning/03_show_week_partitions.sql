SELECT
       schemaname as "Schema"
      ,tablename as "TblName"
      ,partitiontablename as "PartTblName"
      ,partitiontype as "Type"
      ,split_part(partitionrangestart, '::', 1) as "Start"
      ,partitionstartinclusive as "Inclusive?"
      ,split_part(partitionrangeend, '::', 1) as "End"
      ,partitionendinclusive as "Inclusive?"
FROM
     pg_partitions
WHERE
      tablename = 'otp_rpw'
  AND schemaname = 'faa'
;
