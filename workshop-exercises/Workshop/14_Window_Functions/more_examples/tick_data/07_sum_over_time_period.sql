\i ../00_init.sql
\pset null ''

/**********************************************************************
 How do we find the logical value of the counter over an arbitrary
 time period? 
 We need to find the value at the beginning of the period and subtract
 it from the logical sum of counts over the period.
 **********************************************************************/

with t as
( select tick, nb,
       first_value (nb) over ( w ) as first,
       case when lead(nb) over ( w ) < nb
            then nb
            when lead(nb) over ( w ) is null
            then nb
            else null
       end as max
  from measures
  where tick >= 4 and tick < 14   -- our arbitrary time period
  window w as (order by tick)
)
select sum(max) - min(first) as sum from t where max is not null
;
