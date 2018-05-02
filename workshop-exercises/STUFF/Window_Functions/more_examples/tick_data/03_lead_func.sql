\i ../00_init.sql

select tick, nb,
       lead(nb) over (order by tick)
from measures;
