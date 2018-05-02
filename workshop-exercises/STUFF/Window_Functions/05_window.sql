select dest, uniquecarrier, flightnum,  airtime , avg (airtime),
rank() over (order by dest)as rank from otp_r
where origin = 'BOS' and flightdate = '2009-11-30'::date   and airtime > 300
group by dest,uniquecarrier,flightnum,airtime
order by airtime;

