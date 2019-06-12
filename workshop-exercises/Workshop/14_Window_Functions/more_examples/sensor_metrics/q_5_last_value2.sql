\i ../00_init.sql

/***********************************************************************
 * Return the last value in 5 minutes windows.
 ***************
 * Our second try at using last_value().
 * Here, we have changed the frame to
 *         CURRENT ROW to UNBOUNDED FOLLOWING
 * Now, each iteration through the window partition returns the same
 * last value (i.e., the last row in the frame)
 ***********************************************************************/

select measure_ts as "Time", lv as "Last Value"
from (
    select 
       date_trunc_mins (measure_ts, 5) measure_ts,
       last_value(measure_value)
           over (partition by date_trunc_mins (measure_ts, 5)
                 order by measure_ts
                 rows between current row and unbounded following
                ) as lv
    from metrics
    where vehicle_id = 1
      and measure_ts between '2010-10-11 09:00:00'::timestamp
                         and '2010-10-11 16:00:00'::timestamp
) as a
group by measure_ts, lv
order by measure_ts
limit 20
;
