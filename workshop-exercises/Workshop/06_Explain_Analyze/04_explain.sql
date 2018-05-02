EXPLAIN
SELECT avg(depdelayminutes)::numeric(8,1) from faa.otp_rpm f where f.origin = 'BOS'
AND f.FlightDate > '2009-12-31'::date;


