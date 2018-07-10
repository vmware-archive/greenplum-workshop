insert into public.wwearthquakes_lastwk select * from public.ext_wwearthquakes_lastwk;
select count(*) total_records from public.wwearthquakes_lastwk;
select * from public.wwearthquakes_lastwk order by 1 desc limit 100;
