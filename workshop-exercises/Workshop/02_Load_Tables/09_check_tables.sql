select objname, actionname, statime
from pg_stat_operations
where actionname = 'ANALYZE'
  and schemaname = 'faa';

