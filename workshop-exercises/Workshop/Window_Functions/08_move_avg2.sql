update demo.unemp 
set mv5 = foo.mv5 
from (
   select month, avg(unrate) over(order by month ROWS BETWEEN 4 preceding and current row  ) as mv5
   from demo.unemp) foo
where unemp.month = foo.month;

update demo.unemp 
set mv12 = foo.mv12 
from (
   select month, avg(unrate) over(order by month ROWS BETWEEN 11 preceding and current row) as mv12
   from demo.unemp) foo
where unemp.month = foo.month;

select month, unrate, mv5::numeric(6,2), mv12::numeric(6,2)
from demo.unemp
order by month desc
limit 30;
