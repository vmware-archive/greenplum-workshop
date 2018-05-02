\i ../00_init.sql

\set tblname unemp

select month,
       unrate,
       mv5::numeric(6,2),
       mv12::numeric(6,2)
from :tblname
order by month desc
limit 15
;

select avg (unrate) as "AVG",
       stddev (unrate) as "SD_unrate",
       stddev (mv5) as "SD_mv5",
       stddev (mv12) as "SD_mv12"
from :tblname
;
