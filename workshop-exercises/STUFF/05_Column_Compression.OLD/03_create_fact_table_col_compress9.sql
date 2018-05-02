drop table if exists faa.otp_cc9;
CREATE TABLE faa.otp_cc9  (like otp_r)
WITH (appendonly=true, orientation=column, COMPRESSTYPE=ZLIB, COMPRESSLEVEL=9) ;
