drop external table if exists faa.ext_load_otp cascade;
CREATE EXTERNAL TABLE faa.ext_load_otp (LIKE faa.otp_load)
LOCATION ('gpfdist://mdw:8081/On_Time*bz2')
FORMAT 'csv' (header)
LOG ERRORS SEGMENT REJECT LIMIT 50000 rows;


