SELECT nspname || '.' || relname AS "relation",
    pg_size_pretty(pg_total_relation_size(C.oid)) AS "total_size"
  FROM pg_class C
  LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
  WHERE nspname NOT IN ('pg_catalog', 'information_schema')
    AND C.relkind <> 'i'
    AND nspname !~ '^pg_toast'
    AND nspname =  'faa'
    AND relname  like 'otp_c%'
--  ORDER BY pg_total_relation_size(C.oid) DESC
    ORDER BY relname  DESC
  ;

