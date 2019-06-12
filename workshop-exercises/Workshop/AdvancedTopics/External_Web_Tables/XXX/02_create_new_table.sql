create schema faa;

create table faa.d_airlines (airlineid integer, airline_desc text)
distributed by (airlineid);

