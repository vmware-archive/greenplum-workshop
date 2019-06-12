select objname "Table",
       actionname "Operation Performed",
       statime "Operation Timestamp"
from pg_stat_operations
where actionname = 'ANALYZE'
  and schemaname = 'faa';
