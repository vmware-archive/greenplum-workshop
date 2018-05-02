set search_path to faa;

\set ext_tbl ext_otp

DROP EXTERNAL TABLE IF EXISTS :ext_tbl
;

SELECT 'Create External Table ...' as "INFO";

CREATE EXTERNAL TABLE :ext_tbl
    ( LIKE otp_rp )
    LOCATION ('gpfdist://localhost:8082/2009*otp.dat')
    FORMAT 'text' (DELIMITER '~')
;
