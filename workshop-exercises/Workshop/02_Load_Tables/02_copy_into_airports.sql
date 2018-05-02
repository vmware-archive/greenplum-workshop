\COPY faa.d_airports FROM '/home/gpuser/data/faa/L_AIRPORTS.csv'  CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;
select count(*) from faa.d_airports;
select gp_read_error_log('d_airports');
analyze faa.d_airports;
