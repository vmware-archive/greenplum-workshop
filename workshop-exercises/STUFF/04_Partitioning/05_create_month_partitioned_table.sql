Drop Table if exists faa.otp_rpm;
CREATE TABLE faa.otp_rpm (LIKE faa.otp_r)

PARTITION BY RANGE(FlightDate) 
(
    PARTITION mnth START ('2008-01-01'::date)
                  END ('2011-12-31'::date)
                  EVERY ('1 month'::interval),
    DEFAULT PARTITION Out_of_Range
);
