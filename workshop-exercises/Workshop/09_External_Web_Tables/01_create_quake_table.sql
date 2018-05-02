DROP TABLE IF EXISTS public.wwearthquakes_lastwk;
CREATE TABLE public.wwearthquakes_lastwk (
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
