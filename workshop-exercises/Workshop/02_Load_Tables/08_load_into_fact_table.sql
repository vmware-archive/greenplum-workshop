insert into faa.otp_r
select
  l.flt_year,
  l.flt_quarter,
  l.flt_month,
  l.flt_dayofmonth,
  l.flt_dayofweek,
  l.flightdate,
  l.uniquecarrier,
  l.airlineid,
  l.carrier,
  l.flightnum,
  l.origin, -- airport code
  l.origincityname,
  l.originstate,
  l.originstatename,
  l.dest,
  l.destcityname,
  l.deststate,
  l.deststatename,
  l.crsdeptime,
  l.deptime,
  l.depdelay::float8, -- cast from numeric
  l.depdelayminutes::float8, -- cast from numeric
  l.departuredelaygroups::smallint,
  l.taxiout::integer,
  l.wheelsoff,
  l.wheelson,
  l.taxiin::smallint,
  l.crsarrtime,
  l.arrtime,
  l.arrdelay::float8, -- cast from numeric
  l.arrdelayminutes::float8, -- cast from numeric
  l.arrivaldelaygroups::smallint,
  l.cancelled, 
  l.cancellationcode,
  l.diverted,
  l.crselapsedtime::integer, -- cast from numeric
  l.actualelapsedtime::float8, -- cast from numeric
  l.airtime::float8, -- cast from numeric
  l.flights::smallint, -- cast from numeric, always one
  l.distance::float8, -- cast from numeric
  l.distancegroup,
  coalesce(l.carrierdelay::smallint, 0), -- cast from numeric
  coalesce(l.weatherdelay::smallint, 0), -- cast from numeric
  coalesce(l.nasdelay::smallint, 0), -- cast from numeric
  coalesce(l.securitydelay::smallint, 0), -- cast from numeric
  coalesce(l.lateaircraftdelay::smallint, 0) -- cast from numeric
from faa.otp_load l;
analyze faa.otp_r;
