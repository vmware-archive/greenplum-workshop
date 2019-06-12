\i ../00_init.sql

select measure_ts, measure_value
from metrics
where vehicle_id = 1
order by 1
limit 20
;

