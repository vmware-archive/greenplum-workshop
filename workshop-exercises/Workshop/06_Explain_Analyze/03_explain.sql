EXPLAIN
SELECT avg(depdelayminutes)::numeric(8,1) from faa.otp_r f where f.origin = 'BOS';

