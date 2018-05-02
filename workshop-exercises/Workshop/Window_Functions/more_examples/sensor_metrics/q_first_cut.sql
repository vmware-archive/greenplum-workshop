\i ../00_init.sql

select
   date_trunc_mins (measure_ts, 5) measure_ts,
   first_value(measure_value)
       over (partition by date_trunc_mins (measure_ts, 5)
             order by measure_ts desc
            ) as lv
from metrics
where vehicle_id = 1
  and measure_ts between '2010-10-11 09:00:00'::timestamp
                     and '2010-10-11 16:00:00'::timestamp
limit 20
;
