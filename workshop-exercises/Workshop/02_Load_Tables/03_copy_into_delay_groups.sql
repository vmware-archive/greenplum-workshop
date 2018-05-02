\COPY faa.d_delay_groups FROM '/home/gpuser/data/faa/L_ONTIME_DELAY_GROUPS.csv'  CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;
select count(*) from faa.d_delay_groups;
select gp_read_error_log('d_delay_groups');
analyze faa.d_delay_groups;
