SELECT  gp_segment_id, count(*)
FROM faa.otp_r
GROUP BY gp_segment_id ORDER BY gp_segment_id;

\echo '\nWhy all this skew?\n'
select count(distinct(airlineid)) from faa.otp_r;
select airlineid, count(*) 
from faa.otp_r group by airlineid order by 2;

select count(distinct(flightnum)) from faa.otp_r;
