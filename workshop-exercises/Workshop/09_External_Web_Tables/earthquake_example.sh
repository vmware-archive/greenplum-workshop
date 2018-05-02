# Data load from external web source 
# Worldwide earthquakes for the last 7 days  
# https://explore.data.gov/Geography-and-Environment/Worldwide-M1-Earthquakes-Past-7-Days/7tag-iwnu

psql -d gpuser << _EOF_
DROP TABLE IF EXISTS wwearthquakes_lastwk;
CREATE TABLE wwearthquakes_lastwk (
  time TEXT,
  latitude numeric,
  longitude numeric,
  depth numeric,
  mag numeric,
  mag_type varchar (10),
  NST integer,
  gap numeric,
  dmin numeric,
  rms text,
  net text,
  id text,
  updated TEXT,
  place varchar(150),
  type varchar(50),
  horizontalError numeric,
  depthError numeric,
  magError numeric,
  magNst integer,
  status text,
  locationSource text,
  magSource text
)
DISTRIBUTED BY (time);
_EOF_

SQLCMD="DROP EXTERNAL TABLE IF EXISTS ext_wwearthquakes_lastwk; \
create external web table ext_wwearthquakes_lastwk (like wwearthquakes_lastwk) \
Execute 'wget -qO - http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv'  -- defining an OS command to execute \
ON MASTER \
Format 'CSV' (HEADER) \
Segment Reject limit 300; \
grant select on ext_wwearthquakes_lastwk to gpuser; "

sudo su - gpadmin -c  "psql -d gpuser -c \"$SQLCMD\""

# Load and browse the data into the table
psql -d gpuser << _EOF
insert into wwearthquakes_lastwk select * from ext_wwearthquakes_lastwk;
select count(*) total_records from wwearthquakes_lastwk;
select * from wwearthquakes_lastwk order by 1 desc limit 100;
_EOF
