Drop Table if exists faa.otp_rpm;
CREATE TABLE faa.otp_rpm (LIKE faa.otp_r)

PARTITION BY RANGE(FlightDate) 
(
    PARTITION prior_mnths  START ('1900-01-01'::date),
    PARTITION mnth         START ('2008-01-01'::date)
                           END ('2011-12-31'::date) INCLUSIVE
                           EVERY ('1 month'::interval),
    PARTITION future_mnths START ('2012-01-01'::date),
    DEFAULT PARTITION Out_of_Range
);
