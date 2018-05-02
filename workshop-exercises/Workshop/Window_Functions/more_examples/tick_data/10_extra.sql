\i ../00_init.sql
\pset null ''

/**********************************************************************
 Let's create partitions of data ...
 **********************************************************************/

with tops as (
  select tick, nb,
         case when lead(nb) over (w) < nb then nb
              when lead(nb) over (w) is null then nb
             else null
         end as max
    from measures
  window w as (order by tick)
)
  select tick, nb, max,
         (select tick
            from tops t2
           where t2.tick >= t1.tick and max is not null
        order by t2.tick
           limit 1) as p
    from tops t1;
