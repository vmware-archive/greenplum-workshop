select distinct diverted, count(*) from faa.otp_r group by 1;

drop table if exists faa.bad_distro;
create table faa.bad_distro (LIKE faa.otp_r)
distributed by (diverted); 

insert into faa.bad_distro select * from faa.otp_r;

