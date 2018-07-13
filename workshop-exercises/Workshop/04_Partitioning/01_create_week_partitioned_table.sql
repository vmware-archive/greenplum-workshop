Drop Table if exists faa.otp_rp;
CREATE TABLE faa.otp_rpw (LIKE faa.otp_r)

PARTITION BY RANGE(FlightDate) 
(
    PARTITION week START ('2008-01-01'::date)
                  END ('2011-12-31'::date)
                  EVERY ('1 week'::interval),
    DEFAULT PARTITION Out_of_Range
);
