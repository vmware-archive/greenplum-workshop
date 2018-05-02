set search_path to faa;
insert into otp_rpm select * from otp_r;
analyze rootpartition faa.otp_rpm;
