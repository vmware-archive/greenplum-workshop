/***************************************************
 Take some measure as if they came from a counter,
 starting at 0. A reset is indicated when the nb
 value drops from one tick to the next.
 We calculate the total usage by (40 + 60 = 100)
***************************************************/

\i ../00_init.sql
\set tblname measures

drop table if exists :tblname;
create table :tblname
(
    tick int,
    nb   int
)
distributed randomly
;

insert into :tblname
values
   (1, 0), (2, 10), (3, 20), (4, 30), (5, 40),
   (6, 0), (7, 20), (8, 30), (9, 60)
;
