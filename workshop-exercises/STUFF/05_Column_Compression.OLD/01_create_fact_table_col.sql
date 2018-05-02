drop table if exists faa.otp_c;
CREATE TABLE faa.otp_c  (like faa.otp_r)
WITH (appendonly=true, orientation=column);
