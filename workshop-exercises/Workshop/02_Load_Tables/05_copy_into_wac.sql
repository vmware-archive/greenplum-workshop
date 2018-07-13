\COPY faa.d_wac FROM '/home/gpuser/data/faa/L_WORLD_AREA_CODES.csv'  CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;
select count(*) from faa.d_wac;
select gp_read_error_log('d_wac');
analyze faa.d_wac;
