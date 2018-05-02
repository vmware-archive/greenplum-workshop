drop table if exists faa.flight_output;
drop table if exists faa.flight_output_summary;

select madlib.linregr_train(
'faa.otp_r',
'faa.flight_output',
'arrdelay',
'array[1,depdelay]');

\x on
select * from faa.flight_output;
select * from faa.flight_output_summary;
\x off
