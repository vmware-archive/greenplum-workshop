\i 00_init.sql

select
     lot_id, ts, x,
     avg(x)       over ( w1 )::numeric(5,1),
     row_number() over ( w1 )
from :tbl_name
window w1 as (partition by lot_id order by ts)
order by lot_id, ts
;
