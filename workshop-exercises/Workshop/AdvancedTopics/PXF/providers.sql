DROP EXTERNAL TABLE if exists public.pxf_read_providers_parquet ;

CREATE EXTERNAL TABLE public.pxf_read_providers_parquet
(
  provider_id text,
  provider_name text,
  specialty text,
  address_street text,
  address_city text,
  address_state text,
  address_zip text

)
LOCATION ('pxf://user/hive/warehouse/providers.parquet?PROFILE=hdfs:parquet')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

select count(*) from public.pxf_read_providers_parquet;
select * from public.pxf_read_providers_parquet order by provider_id  limit 10;

drop external table if exists public.providers_csv;
create external table public.providers_csv (
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
select count(*) from public.providers_csv;
select * from public.providers_csv order by provider_id limit 10;
