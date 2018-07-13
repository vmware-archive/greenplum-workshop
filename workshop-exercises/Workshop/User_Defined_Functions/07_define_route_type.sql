drop type if exists route cascade;
create type route as (origin_airport text, dest_airport text, airline text);
drop table if exists routes;
create table routes (r1 route) distributed randomly;

