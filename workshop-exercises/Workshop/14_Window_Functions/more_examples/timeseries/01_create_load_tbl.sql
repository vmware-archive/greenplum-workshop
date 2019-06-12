\i 00_init.sql

drop sequence if exists public.timeseries_x_seq cascade;

drop table if exists :tbl_name;
create table :tbl_name
(
    lot_id varchar,
    ts     timestamp,
    x      serial
)
distributed randomly
;

insert into :tbl_name
values
('lot01', now() + random() * interval '1 second', nextval('timeseries_x_seq')),
('lot01', now() + random() * interval '1 second', nextval('timeseries_x_seq')),
('lot01', now() + random() * interval '1 second', nextval('timeseries_x_seq')),
('lot01', now() + random() * interval '1 second', nextval('timeseries_x_seq')),
('lot01', now() + random() * interval '1 second', nextval('timeseries_x_seq')),
('lot01', now() + random() * interval '1 second', nextval('timeseries_x_seq')),
('lot01', now() + random() * interval '1 second', nextval('timeseries_x_seq')),
('lot01', now() + random() * interval '1 second', nextval('timeseries_x_seq')),
('lot01', now() + random() * interval '1 second', nextval('timeseries_x_seq')),
('lot01', now() + random() * interval '1 second', nextval('timeseries_x_seq')),
('lot01', now() + random() * interval '1 second', nextval('timeseries_x_seq'))
;

insert into :tbl_name
values
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq')),
('lot02', now() + random() * interval '999 millisecond', nextval('timeseries_x_seq'))
;


insert into :tbl_name
values
('lot03', now() + random() * interval '532 millisecond', nextval('timeseries_x_seq')),
('lot03', now() + random() * interval '532 millisecond', nextval('timeseries_x_seq')),
('lot03', now() + random() * interval '532 millisecond', nextval('timeseries_x_seq')),
('lot03', now() + random() * interval '532 millisecond', nextval('timeseries_x_seq')),
('lot03', now() + random() * interval '532 millisecond', nextval('timeseries_x_seq')),
('lot03', now() + random() * interval '532 millisecond', nextval('timeseries_x_seq')),
('lot03', now() + random() * interval '532 millisecond', nextval('timeseries_x_seq'))
;





/*
SELECT *
FROM generate_series(now()::timestamp,
                     now() + interval '10 seconds',
		     '1 milliseconds')
order by random()
;
*/
