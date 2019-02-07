select uniquecarrier,
       flightnum,
       dest,
       depdelay ,
       avg (depdelay),
       min (depdelay),
       max(depdelay) over (partition by dest)
from otp_r
where origin = 'BOS'
  and flightdate = '2009-11-30'::date
  and dest in ('LGA', 'DCA', 'JFK','ORD' )
group by dest, depdelay, uniquecarrier, flightnum;

