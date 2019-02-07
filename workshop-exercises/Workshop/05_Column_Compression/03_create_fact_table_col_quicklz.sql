drop table if exists faa.otp_ccqlz;
CREATE TABLE faa.otp_ccqlz  (like otp_r)
WITH (appendonly=true, orientation=column, COMPRESSTYPE=quicklz);
