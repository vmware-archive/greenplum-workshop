drop table if exists faa.d_airlines2;
create table faa.d_airlines2 (like faa.airlines);
insert faa.d_airlines2 seelct * from pxf_read_airlines_parquet;
select count(*) from faa.d_airlines2;
select count(*) from faa.d_airlines;
select * from faa.d_airlines except select * from faa.d_airlines2;
