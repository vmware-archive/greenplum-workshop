insert into wwearthquakes_lastwk select * from ext_wwearthquakes_lastwk;
select count(*) total_records from wwearthquakes_lastwk;
select * from wwearthquakes_lastwk order by 1 desc limit 100;
