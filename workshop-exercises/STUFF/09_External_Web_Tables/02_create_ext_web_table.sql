DROP EXTERNAL TABLE IF EXISTS public.ext_wwearthquakes_lastwk; 
create external web table public.ext_wwearthquakes_lastwk (like wwearthquakes_lastwk) 
Execute 'wget -qO - http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv'  -- defining an OS command to execute 
ON MASTER 
Format 'CSV' (HEADER) 
Segment Reject limit 300; 
grant select on public.ext_wwearthquakes_lastwk to gpuser;


