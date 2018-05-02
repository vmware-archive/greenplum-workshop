\i ../00_init.sql

/***********************************************************************
 * Return the avg value in 5 minutes windows.
 ***********************************************************************/

select measure_ts, avg_value::numeric(6,2) as "Avg_Value"
from (
    select
       date_trunc_5mins (measure_ts) measure_ts,
       AVG(measure_value)
           OVER ( PARTITION BY date_trunc_5mins (measure_ts) ) as avg_value
    from metrics
    where vehicle_id = 1
      and measure_ts between '2010-10-11 09:00:00'::timestamp
                         and '2010-10-11 16:00:00'::timestamp
) as a
group by measure_ts, avg_value
order by measure_ts
limit 10
;
