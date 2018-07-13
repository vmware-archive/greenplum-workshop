drop table if exists faa.otp_cclz;
CREATE TABLE faa.otp_cclz  (like otp_r)
WITH (appendonly=true, orientation=column, COMPRESSTYPE=quicklz);
