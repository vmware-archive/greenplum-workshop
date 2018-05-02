\x 
select count(*)  from faa.otp_r where flightdate = '2008-01-03'::date and origin = 'BOS' and dest = 'LAX' limit 1;
select count(*)  from faa.otp_c where flightdate = '2008-01-03'::date and origin = 'BOS' and dest = 'LAX' limit 1;
select count(*) from faa.otp_cc5 where flightdate = '2008-01-03'::date and origin = 'BOS' and dest = 'LAX' limit 1;
select count(*)  from faa.otp_cc9 where flightdate = '2008-01-03'::date and origin = 'BOS' and dest = 'LAX' limit 1;

