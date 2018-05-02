SELECT
       schemaname || '.' || tablename as "Schema.Table"
      ,partitiontablename as "PartTblName"
      ,partitiontype as "Type"
      ,split_part(partitionrangestart, '::', 1) as "Start"
      ,split_part(partitionrangeend, '::', 1) as "End"
FROM
     pg_partitions
WHERE
      tablename = 'otp_rp'
  AND schemaname = 'faa'
;
