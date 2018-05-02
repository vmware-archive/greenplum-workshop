drop table if exists faa.d_airports;
create table faa.d_airports (
    AirportID      integer, 
    Name           text,
    City           text,
    Country        text,
    airport_code   text,
    ICOA_code      text, 
    Latitude       float8,
    Longitude      float8, 
    Altitude       float8,
    TimeZoneOffset float,
    DST_Flag       text ,
    TZ             text
)
distributed randomly;

drop table if exists faa.d_wac;
create table faa.d_wac (wac smallint, area_desc text)
distributed randomly;

drop table if exists faa.d_airlines;
create table faa.d_airlines (airlineid integer, airline_desc text)
distributed by(airlineid);

drop table if exists faa.d_cancellation_codes;
create table faa.d_cancellation_codes (cancel_code text, cancel_desc text)
distributed randomly;

drop table if exists faa.d_delay_groups;
create table faa.d_delay_groups (delay_group_code text, delay_group_desc text)
distributed randomly;

drop table if exists faa.d_distance_groups;
create table faa.d_distance_groups (distance_group_code text, distance_group_desc text)
distributed randomly;
