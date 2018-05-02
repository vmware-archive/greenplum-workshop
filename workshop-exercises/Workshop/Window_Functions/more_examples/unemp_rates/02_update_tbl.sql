\i ../00_init.sql

\set tblname unemp

update :tblname 
set mv5  = foo.mv5,
    mv12 = foo.mv12 
from
   (
   select month, avg(unrate)
                     over(order by month
                          ROWS BETWEEN 4 preceding and current row)
                       as mv5,
                 avg(unrate)
                     over(order by month
		          ROWS BETWEEN 11 preceding and current row)
		       as mv12
   from :tblname
   ) foo
where :tblname.month = foo.month;
