set search_path to faa;

insert into faa.otp_rpw select * from faa.otp_r;
analyze rootpartition faa.otp_rpw;

select count(*) from faa.otp_r;
select count(*) from faa.otp_rpw;
select count(*) from faa.otp_rpw_1_prt_out_of_range ;
