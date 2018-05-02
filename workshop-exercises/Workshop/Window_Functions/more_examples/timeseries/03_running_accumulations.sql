\i 00_init.sql

select
    ts, x,
    count() over (order by ts),
    sum(x)  over (order by ts)
from :tbl_name
order by ts
;
