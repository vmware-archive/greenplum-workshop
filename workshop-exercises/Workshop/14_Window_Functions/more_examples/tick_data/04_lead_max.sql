\i ../00_init.sql
\pset null ' '

select tick, nb,
       lead(nb) over ( w ),
       case when lead(nb) over ( w ) < nb
            then nb
            when lead(nb) over ( w ) is null
            then nb
            else null
       end as max
from measures
window w as (order by tick)
;
