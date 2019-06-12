-- set search_path=information_schema, pg_catalog, gp_toolkit;
SELECT table_schema, table_name, column_name, column_default, is_nullable, data_type
FROM information_schema.columns
WHERE table_schema = 'faa'
  AND table_name = 'otp_r'
  AND data_type like 'time%'
  -- AND data_type = 'time without time zone'
;
