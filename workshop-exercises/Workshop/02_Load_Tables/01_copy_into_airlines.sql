\COPY faa.d_airlines FROM '/home/gpuser/data/faa/L_AIRLINE_ID.csv'  CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;
select count(*) from faa.d_airlines;
select gp_read_error_log('d_airlines');
analyze faa.d_airlines;
