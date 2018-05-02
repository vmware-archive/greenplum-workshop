\i ../00_init.sql
\pset null ''

/**********************************************************************
 Find the ranges of time (ticks) where the counter didn't reset.
 **********************************************************************/
with tops as (
  select tick, nb,
         case when lead(nb) over (w) < nb then nb
              when lead(nb) over (w) is null then nb
             else null
         end as max
    from measures
  window w as (order by tick)
),
     parts as (
  select tick, nb, max,
         (select tick
            from tops t2
           where t2.tick >= t1.tick and max is not null
        order by t2.tick
           limit 1) as p
    from tops t1
),
     ranges as (
  select first_value(tick) over (w) as start,
         last_value(tick) over (w) as end,
         max(max) over (w)
    from parts
  window w as (partition by p order by tick)
)
select * from ranges where max is not null;
