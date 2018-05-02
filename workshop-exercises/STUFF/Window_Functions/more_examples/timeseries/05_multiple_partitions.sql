\i 00_init.sql

select
     lot_id, ts, x,
     lag(x) over (partition by lot_id order by ts),
     lead(x) over (partition by lot_id order by ts)
from :tbl_name
order by lot_id, ts
;
