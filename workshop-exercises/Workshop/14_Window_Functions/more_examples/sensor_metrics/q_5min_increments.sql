\i ../00_init.sql

/***********************************************************************
 * Return the last value in 5 minutes windows.
 ***************
 * First attempt at using a user defined function to truncate the
 * timestamp to the desired resolution in minutes.
 * From a bit of testing, the cost of flexibility is at the expense of
 * performance. This version is ~4x slower than calling date_part() and
 * date_trunc() directly.
 *
 * This also illustrates another way to find the last value. Here, we
 * use the first_value() function but order the window partition by
 * the measure_ts DESC. Remember, the default frame is still
 *    CURRENT ROW to UNBOUNDED PRECEDING
 * which works in this case.
 ***********************************************************************/

select measure_ts, lv
from (
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
) as a
group by measure_ts, lv
order by measure_ts
limit 10
;
