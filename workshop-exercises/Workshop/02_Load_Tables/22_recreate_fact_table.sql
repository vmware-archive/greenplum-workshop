create table faa.otp_rr (like faa.otp_r) distributed randomly;
insert into faa.otp_rr select * from faa.otp_r;
analyze faa.otp_rr;
