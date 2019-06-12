create external table providers_csv (
  provider_id text,
  provider_name text,
  specialty text,
  address_street text,
  address_city text,
  address_state text,
  address_zip text
)
LOCATION ('pxf://tmp/data/providers/providers_part1.csv?PROFILE=hdfs:text')
FORMAT 'CSV' (HEADER QUOTE '"' delimiter ',' )
;

select * from providers_csv limit 5;
