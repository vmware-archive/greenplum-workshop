set client_min_messages to warning;

create or replace function row_count(p_schemaname text) returns text  as
$$
declare
v_tables record;
v_names text;
v_count integer;
v_test text;
begin
  v_names = '';
  for v_tables in SELECT * from pg_stat_user_tables where schemaname = p_schemaname LOOP
     execute 'select count(*) from ' || v_tables.schemaname || '.' || v_tables.relname into v_count;
     v_names = v_names || ' ' ||v_tables.relname || ' ' || v_count||E'\n';
  END LOOP;
  RETURN v_names;
end;
$$
language plpgsql stable ;

drop schema if exists demo;
create schema demo;
create table demo.airlines as select * from faa.d_airlines;
create table demo.airports as select * from faa.d_airports;

select row_count('demo');
drop schema demo cascade;
