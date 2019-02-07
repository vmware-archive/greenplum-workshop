select count(flightnum)  from faa.otp_r     where flightdate = '2008-01-03'::date and origin = 'BOS' ;
select count(flightnum)  from faa.otp_c     where flightdate = '2008-01-03'::date and origin = 'BOS' ;
select count(flightnum)  from faa.otp_ccz5  where flightdate = '2008-01-03'::date and origin = 'BOS' ;
select count(flightnum)  from faa.otp_ccqlz where flightdate = '2008-01-03'::date and origin = 'BOS' ;

