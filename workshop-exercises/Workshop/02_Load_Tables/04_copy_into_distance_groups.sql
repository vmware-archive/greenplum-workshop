\COPY faa.d_distance_groups FROM '/home/gpuser/data/faa/L_DISTANCE_GROUP_250.csv'  CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;
select count(*) from faa.d_distance_groups;
select gp_read_error_log('d_distance_groups');
analyze faa.d_distance_groups;
