\i 00_init.sql

select
    ts, x,
    lag(x,1)   over (order by ts),
    lead(x,1)  over (order by ts)
from :tbl_name
order by ts
;
