SELECT
       schemaname || '.' || tablename as "Schema.Table"
      ,partitiontablename as "PartTblName"
      ,partitiontype as "Type"
      ,split_part(partitionrangestart, '::', 1) as "Start"
      ,split_part(partitionrangeend, '::', 1) as "End"
      ,case relstorage
           when 'h' then 'heap'
           when 'x' then 'external'
           when 'c' then 'column'
           else 'other'
       end as "Storage"
FROM
     pg_partitions p JOIN pg_class c on p.partitiontablename = c.relname
WHERE
      tablename = 'otp_rpm'
  AND schemaname = 'faa'
;
