select count(*) from faa.d_airlines;
insert into pxf_write_airlines_parquet  select * from faa.d_airlines;
select count(*) from pxf_write_airlines_parquet;

