begin transaction;
  lock table faa.otp_r in access exclusive mode;
  select pg_sleep(60);
rollback;

