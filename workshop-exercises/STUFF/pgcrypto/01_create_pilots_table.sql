drop table if exists pilots, pilots_encrypted;
create table faa.pilots (
   name text,
   license text,
   employeeid int
) distributed randomly; 

create table faa.pilots_encrypted(
   name bytea,
   license text,
   employeeid int)
distributed randomly;
