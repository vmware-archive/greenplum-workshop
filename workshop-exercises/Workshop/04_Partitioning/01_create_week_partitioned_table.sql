Drop Table if exists faa.otp_rp;

CREATE TABLE faa.otp_rpw (LIKE faa.otp_r)
PARTITION BY RANGE(FlightDate) 
(
    PARTITION prior_wks  START ('1900-01-01'::date),
    PARTITION week       START ('2008-01-01'::date)
                         END ('2011-12-31'::date) INCLUSIVE
                         EVERY ('1 week'::interval),
    PARTITION future_wks START ('2012-01-01'::date),
    DEFAULT PARTITION Out_of_Range
);
