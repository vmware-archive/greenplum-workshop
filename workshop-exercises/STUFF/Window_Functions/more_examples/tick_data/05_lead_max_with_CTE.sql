\i ../00_init.sql
\pset null ' '

with t (tick, nb, max) as
( select tick, nb,
       case when lead(nb) over ( w ) < nb
            then nb
            when lead(nb) over ( w ) is null
            then nb
            else null
       end as max
  from measures
  window w as (order by tick)
)
select tick, nb, max from t where max is not null
;
