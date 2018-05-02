\i 00_init.sql

select ts, x,
       avg(x) over (order by ts
                    rows between 1 preceding
		             and current row)::numeric(5,1) as avg2,
       avg(x) over (order by ts
                    rows between 2 preceding
		             and current row)::numeric(5,1) as avg3
from :tbl_name
;
