set search_path to faa;

SELECT 'Exchange Partitions with external table' as "INFO";

ALTER TABLE otp_rp
   EXCHANGE PARTITION for ('2009-11-01'::date)
   WITH TABLE ext_otp
   WITHOUT VALIDATION
;

-- NOTE: The old external table is now a base table (after the exchange).
-- SELECT 'Drop old readable external table (which is now a base table)' as "INFO";
-- DROP TABLE ext_otp;
