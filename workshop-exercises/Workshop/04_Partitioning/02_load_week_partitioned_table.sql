set search_path to faa;

insert into otp_rpw select * from otp_r;
analyze rootpartition otp_rpw;

select count(*) from otp_r;
select count(*) from otp_rpw;
select count(*) from otp_rpw_1_prt_out_of_range ;
