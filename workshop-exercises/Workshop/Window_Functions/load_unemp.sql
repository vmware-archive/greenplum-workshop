create schema demo;
drop table if exists demo.unemp;
create table demo.unemp (month date, unrate float) distributed randomly;
\copy demo.unemp from '/home/gpuser/Exercises/Window_Functions/unrate.csv' CSV HEADER ;
alter table demo.unemp add column mv5 float;
alter table demo.unemp add column mv12 float;
