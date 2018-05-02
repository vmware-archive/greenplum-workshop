drop table if exists faa.deptime;
create table faa.deptime (id int,  dt float8) distributed randomly;
insert into faa.deptime values (1,5.0),(2,10.0),(3,15.0), (4,60.0), (5,-5.0);
 SELECT d.id,d.dt as dep_delay, madlib.linregr_predict(m.coef, ARRAY[1, dt]) as arr_delay
 FROM  faa.deptime d, faa.flight_output m                                              
 ORDER BY d.id;        
