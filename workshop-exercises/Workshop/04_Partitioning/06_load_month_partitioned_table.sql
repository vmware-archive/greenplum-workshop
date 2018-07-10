set search_path to faa;
insert into faa.otp_rpm select * from faa.otp_r;
analyze rootpartition faa.otp_rpm;
