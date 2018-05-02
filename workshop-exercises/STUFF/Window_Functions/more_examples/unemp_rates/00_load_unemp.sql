\i ../00_init.sql

drop table if exists unemp;
create table unemp (month date, unrate float) distributed randomly;
\copy unemp from './unrate.csv' CSV HEADER ;
alter table unemp add column mv5 float;
alter table unemp add column mv12 float;
