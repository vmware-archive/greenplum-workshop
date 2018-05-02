\i ../00_init.sql

\set tblname unemp

update :tblname 
set mv5  = foo.mv5,
    mv12 = foo.mv12 
from
   (
   select month, avg(unrate)
                     over( w1 )
                       as mv5,
                 avg(unrate)
                     over( w2 )
		       as mv12
   from :tblname
   window w1 as (order by month ROWS BETWEEN  4 preceding and current row),
          w2 as (order by month ROWS BETWEEN 11 preceding and current row)
   ) foo
where :tblname.month = foo.month;
