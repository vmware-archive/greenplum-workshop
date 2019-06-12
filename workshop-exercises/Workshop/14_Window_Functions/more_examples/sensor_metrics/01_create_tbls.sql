\i ../00_init.sql

drop table if exists metrics;
create table metrics
(
    vehicle_id int,
    measure_id int,
    measure_ts timestamp,
    measure_value float8
)
distributed randomly
;
